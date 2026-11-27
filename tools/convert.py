#!/usr/bin/env python3
"""Rebuild a GameMaker (2024+/2026) project from a GameMaker Studio 1.4 export.

Input : the 'export' branch produced by .github/workflows/decompile.yml
        (dump/CodeEntries, dump/Sprites, dump/EmbeddedTextures, meta/*.json, meta/audio)
        plus data/ (original external music, icon, splash).
Output: project/PigsRevenge2/PigsRevenge2.yyp and all resources.

Old GMS1 code refers to sprites and sounds by *numeric index* in many places
(e.g. `enemy_sprite_0 = 139`, `PS(0)`). Modern GameMaker does not keep those
indices, so every sprite/sound value in the converted code is kept as its OLD
index, and translated to the real asset only where it is consumed:
  __S(old)   -> sprite asset        (first argument of draw_sprite*, sprite_get_*)
  __SR(spr)  -> old sprite index    (every read of sprite_index)
  __A(old)   -> sound asset         (first argument of audio_* functions)
"""
import json, os, re, shutil, sys, uuid, hashlib
from PIL import Image

EXPORT = sys.argv[1]
DATA = sys.argv[2]
OUT_ROOT = sys.argv[3]
NAME = "PigsRevenge2"
OUT = os.path.join(OUT_ROOT, NAME)

META = os.path.join(EXPORT, "meta")
CODE = os.path.join(EXPORT, "dump", "CodeEntries")
SPRITES_PNG = os.path.join(EXPORT, "dump", "Sprites")
TEXTURES = os.path.join(EXPORT, "dump", "EmbeddedTextures")


def load(n):
    with open(os.path.join(META, n + ".json"), encoding="utf-8") as f:
        return json.load(f)


def uid(*parts):
    """Deterministic UUID so re-running the converter gives identical files."""
    return str(uuid.UUID(hashlib.md5("/".join(map(str, parts)).encode()).hexdigest()))


sprites = load("sprites")
sounds = load("sounds")
objects = load("objects")
rooms = load("rooms")
fonts = load("fonts")
scripts = load("scripts")
tpages = {t["Name"]: t for t in load("texturepages")}
general, options = load("general")

SPRITE_NAMES = [s["Name"] for s in sprites]
SOUND_NAMES = [s["Name"] for s in sounds]
SPRITE_IDX = {n: i for i, n in enumerate(SPRITE_NAMES)}
SOUND_IDX = {n: i for i, n in enumerate(SOUND_NAMES)}
OBJECT_NAMES = [o["Name"] for o in objects]

# ---------------------------------------------------------------- yy writer
def yy(value, indent=0):
    """GameMaker-style JSON: trailing commas, 2-space indent, sorted-like order kept."""
    pad = "  " * indent
    if isinstance(value, dict):
        if not value:
            return "{}"
        inner = "".join(f'{pad}  {json.dumps(k)}:{yy(v, indent + 1)},\n' for k, v in value.items())
        return "{\n" + inner + pad + "}"
    if isinstance(value, list):
        if not value:
            return "[]"
        inner = "".join(f"{pad}  {yy(v, indent + 1)},\n" for v in value)
        return "[\n" + inner + pad + "]"
    if isinstance(value, bool):
        return "true" if value else "false"
    if value is None:
        return "null"
    if isinstance(value, float):
        return repr(value) if value != int(value) else f"{value:.1f}"
    return json.dumps(value, ensure_ascii=False)


def write(path, text, binary=False):
    full = os.path.join(OUT, path)
    os.makedirs(os.path.dirname(full), exist_ok=True)
    with open(full, "wb" if binary else "w", **({} if binary else {"encoding": "utf-8", "newline": "\n"})) as f:
        f.write(text)


def ref(kind, name):
    return {"name": name, "path": f"{kind}/{name}/{name}.yy"}


def folder(name):
    return {"name": name, "path": f"folders/{name}.yy"}


resources = []  # (name, path)

# ---------------------------------------------------------------- GML tokenizer
TOKEN_RE = re.compile(
    r"""
    (?P<ws>\s+)
  | (?P<comment>//[^\n]*|/\*.*?\*/)
  | (?P<str>"(?:[^"\\\n]|\\.)*"|'[^'\n]*')
  | (?P<num>\$[0-9A-Fa-f]+|0x[0-9A-Fa-f]+|\d+\.\d*|\.\d+|\d+)
  | (?P<id>[A-Za-z_]\w*)
  | (?P<op>\+=|-=|\*=|/=|\|=|&=|\^=|==|!=|<=|>=|&&|\|\||\^\^|<<|>>|\+\+|--|[-+*/%<>=!&|^~?:;,.(){}\[\]#@$])
    """,
    re.S | re.X,
)


class Tok:
    __slots__ = ("kind", "text")

    def __init__(self, kind, text):
        self.kind, self.text = kind, text

    def __repr__(self):
        return f"{self.kind}:{self.text}"


def tokenize(src):
    out, pos = [], 0
    while pos < len(src):
        m = TOKEN_RE.match(src, pos)
        if not m:
            raise ValueError(f"cannot tokenize at {pos}: {src[pos:pos+40]!r}")
        out.append(Tok(m.lastgroup, m.group()))
        pos = m.end()
    return out


def join(toks):
    return "".join(t.text for t in toks)


def sig(toks, i, step=1):
    """Index of next significant token from i (inclusive) in direction step."""
    while 0 <= i < len(toks) and toks[i].kind in ("ws", "comment"):
        i += step
    return i


def match_close(toks, i):
    """toks[i] is an opening bracket; return index of matching close."""
    pairs = {"(": ")", "[": "]", "{": "}"}
    open_, close = toks[i].text, pairs[toks[i].text]
    depth = 0
    for j in range(i, len(toks)):
        if toks[j].kind == "op":
            if toks[j].text in pairs:
                depth += 1
            elif toks[j].text in (")", "]", "}"):
                depth -= 1
                if depth == 0:
                    return j
    raise ValueError("unbalanced brackets")


def first_arg_span(toks, lp):
    """lp = index of '(' of a call. Return (start, end_exclusive) of first argument."""
    depth = 0
    start = lp + 1
    for j in range(lp, len(toks)):
        t = toks[j]
        if t.kind != "op":
            continue
        if t.text in "([{":
            depth += 1
        elif t.text in ")]}":
            depth -= 1
            if depth == 0:
                return start, j
        elif t.text == "," and depth == 1:
            return start, j
    raise ValueError("unterminated call")


def rhs_span(toks, i):
    """i = index just after an assignment operator. Return (start, end) up to ';' at depth 0."""
    depth = 0
    for j in range(i, len(toks)):
        t = toks[j]
        if t.kind != "op":
            if t.kind == "ws" and "\n" in t.text and depth == 0 and j > i and join(toks[i:j]).strip():
                # statement without semicolon
                return i, j
            continue
        if t.text in "([{":
            depth += 1
        elif t.text in ")]}":
            if depth == 0:
                return i, j
            depth -= 1
        elif t.text == ";" and depth == 0:
            return i, j
    return i, len(toks)


def lhs_chain_start(toks, i):
    """toks[i] is an identifier preceded maybe by `a.b[c].`; return start index of the chain."""
    start = i
    j = sig(toks, i - 1, -1)
    while j >= 0 and toks[j].kind == "op" and toks[j].text == ".":
        k = sig(toks, j - 1, -1)
        if k < 0:
            break
        if toks[k].kind == "op" and toks[k].text in ")]":
            # walk back over bracket group, then the identifier before it
            depth = 0
            m = k
            while m >= 0:
                if toks[m].kind == "op" and toks[m].text in ")]":
                    depth += 1
                elif toks[m].kind == "op" and toks[m].text in "([":
                    depth -= 1
                    if depth == 0:
                        break
                m -= 1
            k2 = sig(toks, m - 1, -1)
            if k2 >= 0 and toks[k2].kind in ("id", "num"):
                m = k2
            start = m
        elif toks[k].kind in ("id", "num"):
            start = k
        else:
            break
        j = sig(toks, start - 1, -1)
    return start


ASSIGN_OPS = {"=", "+=", "-=", "*=", "/=", "|=", "&=", "^="}

SPRITE_FUNCS = {
    "draw_sprite", "draw_sprite_ext", "draw_sprite_part", "draw_sprite_part_ext", "draw_sprite_pos",
    "draw_sprite_stretched", "draw_sprite_stretched_ext", "draw_sprite_tiled", "draw_sprite_tiled_ext",
    "draw_sprite_general", "sprite_get_width", "sprite_get_height", "sprite_get_number",
    "sprite_get_xoffset", "sprite_get_yoffset", "sprite_get_bbox_left", "sprite_get_bbox_right",
    "sprite_get_bbox_top", "sprite_get_bbox_bottom", "sprite_get_name", "sprite_get_texture",
    "sprite_get_uvs", "sprite_exists",
}
SOUND_FUNCS = {
    "audio_play_sound", "audio_play_sound_at", "audio_play_sound_on", "audio_is_playing", "audio_stop_sound",
    "audio_sound_pitch", "audio_sound_gain", "audio_pause_sound", "audio_resume_sound", "audio_is_paused",
    "audio_sound_length", "audio_sound_get_gain", "audio_sound_get_pitch", "audio_get_name",
}
RENAMES = {
    "instance_create": "__c_instance_create",
    "action_kill_object": "instance_destroy",
    "array_height_2d": "__c_array_height_2d",
    "array_length_1d": "__c_array_length_1d",
    "iap_acquire": "__c_iap_acquire",
}
VIEW_READ = {
    "view_xview": "camera_get_view_x(view_camera[{i}])",
    "view_yview": "camera_get_view_y(view_camera[{i}])",
    "view_wview": "camera_get_view_width(view_camera[{i}])",
    "view_hview": "camera_get_view_height(view_camera[{i}])",
    "view_angle": "camera_get_view_angle(view_camera[{i}])",
}

stats = {"strings_hash": 0, "sprite_consts": 0, "sound_consts": 0, "sprite_wraps": 0, "sound_wraps": 0,
         "sprite_index_reads": 0, "sprite_index_writes": 0, "view_rewrites": 0, "renames": 0}


def convert_string(text):
    if text.startswith("'"):
        body = text[1:-1]
    else:
        body = text[1:-1]
        # decompiler output for GMS1 has no escapes, but be safe: un-escape \" first
        body = body.replace('\\"', '"')
    # GMS1 strings have no escape sequences: a backslash is literal
    body = body.replace("\\", "\\\\")
    if "#" in body:
        stats["strings_hash"] += 1
        # GMS1: '#' is a newline, '\#' a literal '#'
        body = body.replace("\\\\#", "\x00").replace("#", "\\n").replace("\x00", "#")
    body = body.replace('"', '\\"')
    return '"' + body + '"'


def transform(src):
    toks = tokenize(src)

    # 1. strings
    for t in toks:
        if t.kind == "str":
            t.text = convert_string(t.text)

    # 2. function renames + asset name constants -> old numeric index
    for i, t in enumerate(toks):
        if t.kind != "id":
            continue
        p = sig(toks, i - 1, -1)
        after_dot = p >= 0 and toks[p].kind == "op" and toks[p].text == "."
        if after_dot:
            continue
        n = sig(toks, i + 1)
        is_call = n < len(toks) and toks[n].text == "("
        if is_call and t.text in RENAMES:
            t.text = RENAMES[t.text]
            stats["renames"] += 1
        elif not is_call and t.text in SPRITE_IDX:
            t.kind, t.text = "num", str(SPRITE_IDX[t.text])
            stats["sprite_consts"] += 1
        elif not is_call and t.text in SOUND_IDX:
            t.kind, t.text = "num", str(SOUND_IDX[t.text])
            stats["sound_consts"] += 1

    # 3. view_* (GMS1) -> camera functions; sprite_index reads/writes.
    #    Work right-to-left so indices stay valid while we splice.
    i = len(toks) - 1
    while i >= 0:
        t = toks[i]
        if t.kind == "id" and t.text in VIEW_READ:
            p = sig(toks, i - 1, -1)
            if not (p >= 0 and toks[p].text == "."):
                lb = sig(toks, i + 1)
                if lb < len(toks) and toks[lb].text == "[":
                    rb = match_close(toks, lb)
                    idx = join(toks[lb + 1:rb]).strip()
                else:
                    rb, idx = i, "0"
                cam = f"view_camera[{idx}]"
                op_i = sig(toks, rb + 1)
                op = toks[op_i].text if op_i < len(toks) else ""
                if op in ASSIGN_OPS:
                    s, e = rhs_span(toks, op_i + 1)
                    rhs = join(toks[s:e]).strip()
                    cur = VIEW_READ[t.text].format(i=idx)
                    val = rhs if op == "=" else f"{cur} {op[0]} ({rhs})"
                    if t.text == "view_angle":
                        new = f"camera_set_view_angle({cam}, {val})"
                    elif t.text == "view_wview":
                        new = f"camera_set_view_size({cam}, {val}, camera_get_view_height({cam}))"
                    elif t.text == "view_hview":
                        new = f"camera_set_view_size({cam}, camera_get_view_width({cam}), {val})"
                    elif t.text == "view_xview":
                        new = f"camera_set_view_pos({cam}, {val}, camera_get_view_y({cam}))"
                    else:
                        new = f"camera_set_view_pos({cam}, camera_get_view_x({cam}), {val})"
                    toks[i:e] = tokenize(new)
                else:
                    toks[i:rb + 1] = tokenize(VIEW_READ[t.text].format(i=idx))
                stats["view_rewrites"] += 1
        elif t.kind == "id" and t.text == "sprite_index":
            start = lhs_chain_start(toks, i)
            op_i = sig(toks, i + 1)
            op = toks[op_i].text if op_i < len(toks) else ""
            if op in ASSIGN_OPS:
                s, e = rhs_span(toks, op_i + 1)
                rhs = join(toks[s:e]).strip()
                lhs = join(toks[start:i + 1])
                if op == "=":
                    new = f"{lhs} = __S({rhs})"
                else:
                    new = f"{lhs} = __S(__SR({lhs}) {op[0]} ({rhs}))"
                toks[start:e] = tokenize(new)
                stats["sprite_index_writes"] += 1
                i = start
            else:
                chain = join(toks[start:i + 1])
                toks[start:i + 1] = tokenize(f"__SR({chain})")
                stats["sprite_index_reads"] += 1
                i = start
        i -= 1

    # 4. wrap first argument of sprite / sound consuming functions
    i = len(toks) - 1
    while i >= 0:
        t = toks[i]
        if t.kind == "id" and (t.text in SPRITE_FUNCS or t.text in SOUND_FUNCS):
            p = sig(toks, i - 1, -1)
            lp = sig(toks, i + 1)
            if not (p >= 0 and toks[p].text == ".") and lp < len(toks) and toks[lp].text == "(":
                s, e = first_arg_span(toks, lp)
                if join(toks[s:e]).strip():
                    w = "__S" if t.text in SPRITE_FUNCS else "__A"
                    toks[s:e] = tokenize(f"{w}({join(toks[s:e]).strip()})")
                    stats["sprite_wraps" if w == "__S" else "sound_wraps"] += 1
        i -= 1

    return join(toks)


def read_code(name):
    p = os.path.join(CODE, name + ".gml")
    with open(p, encoding="utf-8") as f:
        return f.read()


# ---------------------------------------------------------------- folders
FOLDERS = ["Sprites", "Sounds", "Fonts", "Scripts", "Objects", "Rooms", "Compatibility"]

# ---------------------------------------------------------------- sprites
COLLISION = {"AxisAlignedRect": 1, "Precise": 4, "RotatedRect": 5}
for si, s in enumerate(sprites):
    name = s["Name"]
    n_frames = len(s.get("Textures") or [])
    layer_id = uid(name, "layer")
    frames, keyframes = [], []
    for fi in range(n_frames):
        fid = uid(name, "frame", fi)
        src = os.path.join(SPRITES_PNG, f"{name}_{fi}.png")
        im = Image.open(src).convert("RGBA")
        if im.size != (s["Width"], s["Height"]):
            canvas = Image.new("RGBA", (s["Width"], s["Height"]), (0, 0, 0, 0))
            canvas.paste(im, (0, 0))
            im = canvas
        os.makedirs(os.path.join(OUT, "sprites", name, "layers", fid), exist_ok=True)
        im.save(os.path.join(OUT, "sprites", name, f"{fid}.png"))
        im.save(os.path.join(OUT, "sprites", name, "layers", fid, f"{layer_id}.png"))
        frames.append({"$GMSpriteFrame": "v1", "%Name": fid, "name": fid, "resourceType": "GMSpriteFrame", "resourceVersion": "2.0"})
        keyframes.append({
            "$Keyframe<SpriteFrameKeyframe>": "",
            "Channels": {"0": {"$SpriteFrameKeyframe": "", "Id": {"name": fid, "path": f"sprites/{name}/{name}.yy"},
                               "resourceType": "SpriteFrameKeyframe", "resourceVersion": "2.0"}},
            "Disabled": False, "id": uid(name, "kf", fi), "IsCreationKey": False, "Key": float(fi), "Length": 1.0,
            "resourceType": "Keyframe<SpriteFrameKeyframe>", "resourceVersion": "2.0", "Stretch": False,
        })
    ox, oy = s["OriginX"], s["OriginY"]
    data = {
        "$GMSprite": "v2",
        "%Name": name,
        "bboxMode": s["BBoxMode"],
        "bbox_bottom": s["MarginBottom"],
        "bbox_left": s["MarginLeft"],
        "bbox_right": s["MarginRight"],
        "bbox_top": s["MarginTop"],
        "collisionKind": COLLISION.get(s["SepMasks"], 1),
        "collisionTolerance": 0,
        "DynamicTexturePage": False,
        "edgeFiltering": False,
        "For3D": False,
        "frames": frames,
        "gridX": 0,
        "gridY": 0,
        "height": s["Height"],
        "HTile": False,
        "layers": [{"$GMImageLayer": "", "%Name": layer_id, "blendMode": 0, "displayName": "default", "isLocked": False,
                    "name": layer_id, "opacity": 100.0, "resourceType": "GMImageLayer", "resourceVersion": "2.0", "visible": True}],
        "name": name,
        "nineSlice": None,
        "origin": 9,  # custom
        "parent": folder("Sprites"),
        "preMultiplyAlpha": False,
        "resourceType": "GMSprite",
        "resourceVersion": "2.0",
        "sequence": {
            "$GMSequence": "v1",
            "%Name": name,
            "autoRecord": True,
            "backdropHeight": 768,
            "backdropImageOpacity": 0.5,
            "backdropImagePath": "",
            "backdropWidth": 1366,
            "backdropXOffset": 0.0,
            "backdropYOffset": 0.0,
            "events": {"$KeyframeStore<MessageEventKeyframe>": "", "Keyframes": [], "resourceType": "KeyframeStore<MessageEventKeyframe>", "resourceVersion": "2.0"},
            "eventStubScript": None,
            "eventToFunction": {},
            "length": float(max(n_frames, 1)),
            "lockOrigin": False,
            "moments": {"$KeyframeStore<MomentsEventKeyframe>": "", "Keyframes": [], "resourceType": "KeyframeStore<MomentsEventKeyframe>", "resourceVersion": "2.0"},
            "name": name,
            "playback": 1,
            "playbackSpeed": 1.0,
            "playbackSpeedType": 1,  # frames per game frame, like GMS1 image_speed = 1
            "resourceType": "GMSequence",
            "resourceVersion": "2.0",
            "showBackdrop": True,
            "showBackdropImage": False,
            "timeUnits": 1,
            "tracks": [{
                "$GMSpriteFramesTrack": "", "builtinName": 0, "events": [], "inheritsTrackColour": True, "interpolation": 1,
                "isCreationTrack": False,
                "keyframes": {"$KeyframeStore<SpriteFrameKeyframe>": "", "Keyframes": keyframes,
                              "resourceType": "KeyframeStore<SpriteFrameKeyframe>", "resourceVersion": "2.0"},
                "modifiers": [], "name": "frames", "resourceType": "GMSpriteFramesTrack", "resourceVersion": "2.0",
                "spriteId": None, "trackColour": 0, "tracks": [], "traits": 0,
            }],
            "visibleRange": None,
            "volume": 1.0,
            "xorigin": ox,
            "yorigin": oy,
        },
        "swatchColours": None,
        "swfPrecision": 2.525,
        "textureGroupId": {"name": "Default", "path": "texturegroups/Default"},
        "type": 0,
        "VTile": False,
        "width": s["Width"],
    }
    write(f"sprites/{name}/{name}.yy", yy(data))
    resources.append((name, f"sprites/{name}/{name}.yy"))

# ---------------------------------------------------------------- sounds
AUDIO_DIR = os.path.join(META, "audio")
for s in sounds:
    name = s["Name"]
    external = "IsEmbedded" not in (s.get("Flags") or "")
    if external:
        src = os.path.join(DATA, s["File"])
        fname = name + os.path.splitext(s["File"])[1]
    else:
        src = os.path.join(AUDIO_DIR, name + ".wav")
        fname = name + ".wav"
    os.makedirs(os.path.join(OUT, "sounds", name), exist_ok=True)
    shutil.copyfile(src, os.path.join(OUT, "sounds", name, fname))
    data = {
        "$GMSound": "v2",
        "%Name": name,
        "audioGroupId": {"name": "audiogroup_default", "path": "audiogroups/audiogroup_default"},
        "bitDepth": 1,
        "channelFormat": 1,
        "compression": 3 if external else 0,  # 3 = compressed + streamed (music)
        "compressionQuality": 4,
        "conversionMode": 0,
        "duration": 0.0,
        "exportDir": "",
        "name": name,
        "parent": folder("Sounds"),
        "preload": not external,
        "resourceType": "GMSound",
        "resourceVersion": "2.0",
        "sampleRate": 44100,
        "soundFile": fname,
        "volume": float(s.get("Volume", 1)),
    }
    write(f"sounds/{name}/{name}.yy", yy(data))
    resources.append((name, f"sounds/{name}/{name}.yy"))

# ---------------------------------------------------------------- fonts
tex_cache = {}
for f in fonts:
    name = f["Name"]
    pi = tpages[f["Texture"]]
    page = pi["TexturePage"]
    if page not in tex_cache:
        tex_cache[page] = Image.open(os.path.join(TEXTURES, page + ".png")).convert("RGBA")
    tex = tex_cache[page]
    w, h = pi["BoundingWidth"], pi["BoundingHeight"]
    region = tex.crop((pi["SourceX"], pi["SourceY"], pi["SourceX"] + pi["SourceWidth"], pi["SourceY"] + pi["SourceHeight"]))
    png = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    png.paste(region, (pi["TargetX"], pi["TargetY"]))
    os.makedirs(os.path.join(OUT, "fonts", name), exist_ok=True)
    png.save(os.path.join(OUT, "fonts", name, name + ".png"))
    glyphs, chars = {}, []
    for g in f["Glyphs"]:
        c = g["Character"]
        chars.append(c)
        glyphs[str(c)] = {"character": c, "h": g["SourceHeight"], "offset": g["Offset"], "shift": g["Shift"],
                          "w": g["SourceWidth"], "x": g["SourceX"], "y": g["SourceY"]}
    chars.sort()
    ranges, lo = [], None
    for c in chars:
        if lo is None:
            lo = hi = c
        elif c == hi + 1:
            hi = c
        else:
            ranges.append({"lower": lo, "upper": hi})
            lo = hi = c
    if lo is not None:
        ranges.append({"lower": lo, "upper": hi})
    data = {
        "$GMFont": "",
        "%Name": name,
        "AntiAlias": 1,
        "applyKerning": 0,
        "ascender": 0,
        "ascenderOffset": 0,
        "bold": bool(f["Bold"]),
        "canGenerateBitmap": False,
        "charset": f.get("Charset", 0),
        "first": 0,
        "fontName": f["DisplayName"],
        "glyphOperations": 0,
        "glyphs": glyphs,
        "hinting": 0,
        "includeTTF": False,
        "interpreter": 0,
        "italic": bool(f["Italic"]),
        "kerningPairs": [],
        "last": 0,
        "lineHeight": 0,
        "maintainGms1Font": True,
        "name": name,
        "parent": folder("Fonts"),
        "pointRounding": 0,
        "ranges": ranges,
        "regenerateBitmap": False,
        "resourceType": "GMFont",
        "resourceVersion": "2.0",
        "sampleText": "abcdef ABCDEF\n0123456789 .,<>\"'&!?\nабвгд АБВГД ґєії",
        "sdfSpread": 8,
        "size": float(f["EmSize"]),
        "styleName": "Regular",
        "textureGroupId": {"name": "Default", "path": "texturegroups/Default"},
        "TTFName": "",
        "usesSDF": False,
    }
    write(f"fonts/{name}/{name}.yy", yy(data))
    resources.append((name, f"fonts/{name}/{name}.yy"))

# ---------------------------------------------------------------- scripts
def script_yy(name, parent="Scripts"):
    return yy({"$GMScript": "v1", "%Name": name, "isCompatibility": False, "isDnD": False, "name": name,
               "parent": folder(parent), "resourceType": "GMScript", "resourceVersion": "2.0"})


for s in scripts:
    name = s["Name"]
    body = transform(read_code(f"gml_Script_{name}"))
    body = "\n".join("    " + l if l.strip() else "" for l in body.splitlines())
    write(f"scripts/{name}/{name}.gml", f"function {name}() {{\n{body}\n}}\n")
    write(f"scripts/{name}/{name}.yy", script_yy(name))
    resources.append((name, f"scripts/{name}/{name}.yy"))

# compatibility layer
depths = ",\n".join(f'    {json.dumps(o["Name"])}: {o["Depth"]}' for o in objects)
spr_list = ",\n".join(f'        asset_get_index({json.dumps(n)})' for n in SPRITE_NAMES)
snd_list = ",\n".join(f'        asset_get_index({json.dumps(n)})' for n in SOUND_NAMES)
compat = f"""// Generated by tools/convert.py - GMS 1.4 compatibility layer.

/// Old GMS1 sprite index -> sprite asset (in the original order).
function __compat_init() {{
    if (variable_global_exists("__SPR")) return;
    global.__SPR = [
{spr_list}
    ];
    global.__SND = [
{snd_list}
    ];
    global.__SPRR = {{}};
    for (var i = 0; i < array_length(global.__SPR); i++) {{
        var s = global.__SPR[i];
        if (s == -1) show_debug_message("[compat] missing sprite at old index " + string(i));
        else global.__SPRR[$ sprite_get_name(s)] = i;
    }}
    for (var i = 0; i < array_length(global.__SND); i++) {{
        if (global.__SND[i] == -1) show_debug_message("[compat] missing sound at old index " + string(i));
    }}
    global.__ODEPTH = {{
{depths}
    }};
}}

function __S(v) {{
    if (typeof(v) == "number" && v >= 0 && v < array_length(global.__SPR)) return global.__SPR[v];
    return v;
}}

function __SR(v) {{
    if (typeof(v) == "number" && v < 0) return v;
    if (!sprite_exists(v)) return -1;
    var n = global.__SPRR[$ sprite_get_name(v)];
    return is_undefined(n) ? v : n;
}}

function __A(v) {{
    if (typeof(v) == "number" && v >= 0 && v < array_length(global.__SND)) return global.__SND[v];
    return v;
}}

/// GMS1 instance_create: instances take the depth of their object.
function __c_instance_create(_x, _y, _obj) {{
    var d = global.__ODEPTH[$ object_get_name(_obj)];
    return instance_create_depth(_x, _y, is_undefined(d) ? 0 : d, _obj);
}}

/// GMS1: height of a 2D array = number of rows (1 for a 1D array).
function __c_array_height_2d(a) {{
    if (!is_array(a)) return 0;
    var n = array_length(a);
    if (n == 0) return 0;
    for (var i = 0; i < n; i++) if (is_array(a[i])) return n;
    return 1;
}}

/// GMS1: length of a 1D array, or of row 0 of a 2D array.
function __c_array_length_1d(a) {{
    if (!is_array(a)) return 0;
    if (array_length(a) > 0 && is_array(a[0])) return array_length(a[0]);
    return array_length(a);
}}

/// In-app purchases are not available in this port.
function __c_iap_acquire(product, payload) {{
    show_debug_message("[compat] iap_acquire(" + string(product) + ") ignored");
    return -1;
}}

"""
# Stubs for the Android-only Chartboost ad extension (no ads in this port).
for ext in load("extensions"):
    for ef in ext.get("Files") or []:
        for fn in ef.get("Functions") or []:
            compat += f"\nfunction {fn['Name']}() {{ return 0; }} // {ext['Name']} extension stub\n"
write("scripts/__compat/__compat.gml", compat)
write("scripts/__compat/__compat.yy", script_yy("__compat", "Compatibility"))
resources.append(("__compat", "scripts/__compat/__compat.yy"))

# ---------------------------------------------------------------- objects
EVENT_FILE = {0: "Create", 1: "Destroy", 2: "Alarm", 3: "Step", 4: "Collision", 5: "Keyboard", 6: "Mouse",
              7: "Other", 8: "Draw", 9: "KeyPress", 10: "KeyRelease", 12: "CleanUp", 13: "Gesture"}
for o in objects:
    name = o["Name"]
    events = []
    for etype, lst in enumerate(o["Events"]):
        for e in lst:
            sub = e["EventSubtype"]
            code = "\n\n".join(transform(read_code(a["CodeId"])) for a in e["Actions"] if a.get("CodeId"))
            if etype == 4:
                other = OBJECT_NAMES[sub]
                fname = f"Collision_{other}.gml"
                events.append({"$GMEvent": "v1", "%Name": "", "collisionObjectId": ref("objects", other), "eventNum": 0,
                               "eventType": 4, "isDnD": False, "name": "", "resourceType": "GMEvent", "resourceVersion": "2.0"})
            else:
                fname = f"{EVENT_FILE[etype]}_{sub}.gml"
                events.append({"$GMEvent": "v1", "%Name": "", "collisionObjectId": None, "eventNum": sub,
                               "eventType": etype, "isDnD": False, "name": "", "resourceType": "GMEvent", "resourceVersion": "2.0"})
            if etype == 0:
                code = "__compat_init();\n" + code
            write(f"objects/{name}/{fname}", code)
    data = {
        "$GMObject": "",
        "%Name": name,
        "eventList": events,
        "managed": True,
        "name": name,
        "overriddenProperties": [],
        "parent": folder("Objects"),
        "parentObjectId": ref("objects", o["ParentId"]) if o.get("ParentId") else None,
        "persistent": bool(o["Persistent"]),
        "physicsAngularDamping": 0.1, "physicsDensity": 0.5, "physicsFriction": 0.2, "physicsGroup": 1,
        "physicsKinematic": False, "physicsLinearDamping": 0.1, "physicsObject": False, "physicsRestitution": 0.1,
        "physicsSensor": False, "physicsShape": 1, "physicsShapePoints": [], "physicsStartAwake": True,
        "properties": [],
        "resourceType": "GMObject",
        "resourceVersion": "2.0",
        "solid": bool(o["Solid"]),
        "spriteId": ref("sprites", o["Sprite"]) if o.get("Sprite") else None,
        "spriteMaskId": ref("sprites", o["TextureMaskId"]) if o.get("TextureMaskId") else None,
        "visible": bool(o["Visible"]),
    }
    write(f"objects/{name}/{name}.yy", yy(data))
    resources.append((name, f"objects/{name}/{name}.yy"))

# ---------------------------------------------------------------- rooms
room_order = []
for r in rooms:
    name = r["Name"]
    views = []
    for v in (r.get("Views") or [])[:8]:
        views.append({"hborder": v["BorderX"], "hport": v["PortHeight"], "hspeed": v["SpeedX"], "hview": v["ViewHeight"],
                      "inherit": False, "objectId": ref("objects", v["ObjectId"]) if v.get("ObjectId") else None,
                      "vborder": v["BorderY"], "visible": bool(v["Enabled"]), "vspeed": v["SpeedY"],
                      "wport": v["PortWidth"], "wview": v["ViewWidth"], "xport": v["PortX"], "xview": v["ViewX"],
                      "yport": v["PortY"], "yview": v["ViewY"]})
    while len(views) < 8:
        views.append({"hborder": 32, "hport": 768, "hspeed": -1, "hview": 768, "inherit": False, "objectId": None,
                      "vborder": 32, "visible": False, "vspeed": -1, "wport": 1024, "wview": 1024, "xport": 0, "xview": 0,
                      "yport": 0, "yview": 0})
    bg = r["BackgroundColor"] & 0xFFFFFFFF
    has_cc = bool(r.get("CreationCodeId"))
    if has_cc:
        write(f"rooms/{name}/RoomCreationCode.gml", "__compat_init();\n" + transform(read_code(r["CreationCodeId"])))
    data = {
        "$GMRoom": "v1",
        "%Name": name,
        "creationCodeFile": f"rooms/{name}/RoomCreationCode.gml" if has_cc else "",
        "inheritCode": False,
        "inheritCreationOrder": False,
        "inheritLayers": False,
        "instanceCreationOrder": [],
        "isDnd": False,
        "layers": [
            {"$GMRInstanceLayer": "", "%Name": "Instances", "depth": 0, "effectEnabled": True, "effectType": None,
             "gridX": 16, "gridY": 16, "hierarchyFrozen": False, "inheritLayerDepth": False, "inheritLayerSettings": False,
             "inheritSubLayers": True, "inheritVisibility": True, "instances": [], "layers": [], "name": "Instances",
             "properties": [], "resourceType": "GMRInstanceLayer", "resourceVersion": "2.0", "userdefinedDepth": False,
             "visible": True},
            {"$GMRBackgroundLayer": "", "%Name": "Background", "animationFPS": 15.0, "animationSpeedType": 0,
             "colour": (0xFF << 24) | (bg & 0xFFFFFF), "depth": 1000000100, "effectEnabled": True, "effectType": None,
             "gridX": 16, "gridY": 16, "hierarchyFrozen": False, "hspeed": 0.0, "htiled": False, "inheritLayerDepth": False,
             "inheritLayerSettings": False, "inheritSubLayers": True, "inheritVisibility": True, "layers": [],
             "name": "Background", "properties": [], "resourceType": "GMRBackgroundLayer", "resourceVersion": "2.0",
             "spriteId": None, "stretch": False, "userdefinedAnimFPS": False, "userdefinedDepth": True,
             "visible": bool(r.get("DrawBackgroundColor")), "vspeed": 0.0, "vtiled": False, "x": 0, "y": 0},
        ],
        "name": name,
        "parent": folder("Rooms"),
        "parentRoom": None,
        "physicsSettings": {"inheritPhysicsSettings": False, "PhysicsWorld": bool(r.get("World")),
                            "PhysicsWorldGravityX": float(r["GravityX"]), "PhysicsWorldGravityY": float(r["GravityY"]),
                            "PhysicsWorldPixToMetres": float(r["MetersPerPixel"])},
        "resourceType": "GMRoom",
        "resourceVersion": "2.0",
        "roomSettings": {"Height": r["Height"], "inheritRoomSettings": False, "persistent": bool(r["Persistent"]), "Width": r["Width"]},
        "sequenceId": None,
        "views": views,
        "viewSettings": {"clearDisplayBuffer": True, "clearViewBackground": False,
                         "enableViews": "EnableViews" in (r.get("Flags") or ""), "inheritViewSettings": False},
        "volume": 1.0,
    }
    write(f"rooms/{name}/{name}.yy", yy(data))
    resources.append((name, f"rooms/{name}/{name}.yy"))
    room_order.append(name)

# ---------------------------------------------------------------- options
GAME_SPEED = rooms[0]["Speed"] if rooms else 30
main_opts = {
    "$GMMainOptions": "v5",
    "%Name": "Main",
    "name": "Main",
    "option_allow_instance_change": True,
    "option_audio_error_behaviour": True,
    "option_author": "",
    "option_collision_compatibility": True,
    "option_copy_on_write_enabled": True,  # GMS1 arrays were copy-on-write
    "option_draw_colour": 4294967295,
    "option_gameguid": uid(NAME, "guid"),
    "option_gameid": "0",
    "option_game_speed": GAME_SPEED,
    "option_legacy_json_parsing": True,
    "option_legacy_number_conversion": True,
    "option_legacy_other_behaviour": True,
    "option_legacy_primitive_drawing": True,
    "option_mips_for_3d_textures": False,
    "option_remove_unused_assets": False,  # assets are looked up by name at runtime
    "option_sci_usesci": False,
    "option_spine_licence": True,
    "option_steam_app_id": "0",
    "option_template_description": None,
    "option_template_icon": "${base_options_dir}/main/template_icon.png",
    "option_template_image": "${base_options_dir}/main/template_image.png",
    "option_window_colour": 255,
    "resourceType": "GMMainOptions",
    "resourceVersion": "2.0",
}
write("options/main/options_main.yy", yy(main_opts))

# iOS icons and launch screens from the original APK art
icon = Image.open(os.path.join(DATA, "icon.png")).convert("RGBA")
ICONS = {
    "ipad_app_152": ("app/ipad_152.png", 152), "ipad_app_76": ("app/ipad_76.png", 76),
    "ipad_notification_20": ("notification/ipad_20.png", 20), "ipad_notification_40": ("notification/ipad_40.png", 40),
    "ipad_pro_app_167": ("app/ipad_pro_167.png", 167), "ipad_settings_29": ("settings/ipad_29.png", 29),
    "ipad_settings_58": ("settings/ipad_58.png", 58), "ipad_spotlight_40": ("spotlight/ipad_40.png", 40),
    "ipad_spotlight_80": ("spotlight/ipad_80.png", 80), "iphone_app_120": ("app/iphone_120.png", 120),
    "iphone_app_180": ("app/iphone_180.png", 180), "iphone_notification_40": ("notification/iphone_40.png", 40),
    "iphone_notification_60": ("notification/iphone_60.png", 60), "iphone_settings_58": ("settings/iphone_58.png", 58),
    "iphone_settings_87": ("settings/iphone_87.png", 87), "iphone_spotlight_120": ("spotlight/iphone_120.png", 120),
    "iphone_spotlight_80": ("spotlight/iphone_80.png", 80), "itunes_artwork_1024": ("itunes/itunes_1024.png", 1024),
}
ios = {"$GMiOSOptions": "v1", "%Name": "iOS", "name": "iOS", "option_ios_build_number": 0,
       "option_ios_bundle_name": "com.maxgyric.pigsrevenge2", "option_ios_defer_home_indicator": False,
       "option_ios_devices": 2, "option_ios_display_name": "Pigs Revenge 2", "option_ios_enable_broadcast": False,
       "option_ios_half_ipad1_textures": False}
for key, (rel, size) in ICONS.items():
    p = os.path.join(OUT, "options", "ios", "icons", rel)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    img = icon.resize((size, size), Image.LANCZOS)
    if size == 1024:  # App Store artwork must not have alpha
        bgimg = Image.new("RGB", img.size, (255, 255, 255))
        bgimg.paste(img, mask=img.split()[3])
        img = bgimg
    img.save(p)
    ios[f"option_ios_icon_{key}"] = "${options_dir}/ios/icons/" + rel
splash = Image.open(os.path.join(DATA, "splash.png")).convert("RGB")
os.makedirs(os.path.join(OUT, "options", "ios", "splash"), exist_ok=True)
splash.save(os.path.join(OUT, "options", "ios", "splash", "launchscreen-landscape.png"))
Image.open(os.path.join(DATA, "portrait_splash.png")).convert("RGB").save(os.path.join(OUT, "options", "ios", "splash", "launchscreen.png"))
ios.update({
    "option_ios_interpolate_pixels": True,
    "option_ios_launchscreen_fill": 0,
    "option_ios_launchscreen_image": "${options_dir}/ios/splash/launchscreen.png",
    "option_ios_launchscreen_image_landscape": "${options_dir}/ios/splash/launchscreen-landscape.png",
    "option_ios_min_version": "15.0",
    "option_ios_orientation_landscape": True,
    "option_ios_orientation_landscape_flipped": True,
    "option_ios_orientation_portrait": False,
    "option_ios_orientation_portrait_flipped": False,
    "option_ios_output_dir": "~/gamemakerstudio2",
    "option_ios_podfile_lock_path": "${options_dir}/ios/Podfile.lock",
    "option_ios_podfile_path": "${options_dir}/ios/Podfile",
    "option_ios_scale": 0,
    "option_ios_splashscreen_background_colour": 0,
    "option_ios_team_id": "",
    "option_ios_texture_page": "2048x2048",
    "option_ios_version": "1.0.2.0",
    "resourceType": "GMiOSOptions",
    "resourceVersion": "2.0",
})
write("options/ios/options_ios.yy", yy(ios))

# ---------------------------------------------------------------- project
folders = [{"$GMFolder": "", "%Name": f, "folderPath": f"folders/{f}.yy", "name": f, "resourceType": "GMFolder",
            "resourceVersion": "2.0"} for f in FOLDERS]
yyp = {
    "$GMProject": "v1",
    "%Name": NAME,
    "AudioGroups": [{"$GMAudioGroup": "v1", "%Name": "audiogroup_default", "exportDir": "", "name": "audiogroup_default",
                     "resourceType": "GMAudioGroup", "resourceVersion": "2.0", "targets": -1}],
    "configs": {"children": [], "name": "Default"},
    "defaultScriptType": 1,
    "Folders": folders,
    "ForcedPrefabProjectReferences": [],
    "IncludedFiles": [],
    "isEcma": False,
    "LibraryEmitters": [],
    "MetaData": {"IDEVersion": os.environ.get("GM_IDE_VERSION", "2026.100.0.1149")},
    "name": NAME,
    "resources": [{"id": {"name": n, "path": p}} for n, p in sorted(resources, key=lambda r: r[0].lower())],
    "resourceType": "GMProject",
    "resourceVersion": "2.0",
    "RoomOrderNodes": [{"roomId": ref("rooms", n)} for n in room_order],
    "templateType": None,
    "TextureGroups": [{"$GMTextureGroup": "", "%Name": "Default", "autocrop": True, "border": 2, "compressFormat": "bz2",
                       "customOptions": "", "directory": "", "groupParent": None, "isScaled": True, "loadType": "default",
                       "mipsToGenerate": 0, "name": "Default", "resourceType": "GMTextureGroup", "resourceVersion": "2.0",
                       "targets": -1}],
}
write(f"{NAME}.yyp", yy(yyp))
print(json.dumps(stats, indent=1))
print(f"resources: {len(resources)}  -> {OUT}")
