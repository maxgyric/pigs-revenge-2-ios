// Exports everything needed to rebuild a GameMaker project from a data file:
// metadata of objects, rooms, sprites, sounds, fonts, general info as JSON,
// plus raw embedded audio. Output dir: env PR2_OUT (default: <datafile dir>/meta).
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.Json;
using UndertaleModLib;
using UndertaleModLib.Models;

EnsureDataLoaded();

string outDir = Environment.GetEnvironmentVariable("PR2_OUT");
if (string.IsNullOrEmpty(outDir))
    outDir = Path.Combine(Path.GetDirectoryName(FilePath), "meta");
Directory.CreateDirectory(outDir);

var skipTypes = new HashSet<Type> { typeof(byte[]) };
var skipProps = new HashSet<string> { "TextureData", "Data", "Image", "PngData", "RawData", "Instructions" };

void WriteValue(Utf8JsonWriter w, object v, int depth, bool isRoot)
{
    if (v == null) { w.WriteNullValue(); return; }
    var t = v.GetType();
    if (v is UndertaleString us) { w.WriteStringValue(us.Content); return; }
    if (v is string s) { w.WriteStringValue(s); return; }
    if (v is bool b) { w.WriteBooleanValue(b); return; }
    if (t.IsEnum) { w.WriteStringValue(v.ToString()); return; }
    if (v is float f) { if (float.IsFinite(f)) w.WriteNumberValue(f); else w.WriteStringValue(f.ToString()); return; }
    if (v is double d) { if (double.IsFinite(d)) w.WriteNumberValue(d); else w.WriteStringValue(d.ToString()); return; }
    if (t.IsPrimitive || v is decimal) { w.WriteRawValue(Convert.ToString(v, System.Globalization.CultureInfo.InvariantCulture)); return; }
    if (skipTypes.Contains(t)) { w.WriteStringValue("<bytes>"); return; }
    if (!isRoot && v is UndertaleNamedResource nr)
    {
        w.WriteStringValue(nr.Name?.Content);
        return;
    }
    if (depth > 6) { w.WriteStringValue(v.ToString()); return; }
    if (v is IEnumerable en && !(v is UndertaleNamedResource))
    {
        w.WriteStartArray();
        foreach (var item in en)
        {
            object it = item;
            // UndertaleResourceById<T> style wrappers expose .Resource
            var rp = it?.GetType().GetProperty("Resource");
            if (rp != null && it.GetType().Name.StartsWith("UndertaleResourceById")) it = rp.GetValue(it);
            WriteValue(w, it, depth + 1, false);
        }
        w.WriteEndArray();
        return;
    }
    {
        var rp = t.GetProperty("Resource");
        if (rp != null && t.Name.StartsWith("UndertaleResourceById"))
        {
            WriteValue(w, rp.GetValue(v), depth + 1, false);
            return;
        }
    }
    w.WriteStartObject();
    w.WriteString("$type", t.Name);
    foreach (var p in t.GetProperties(BindingFlags.Public | BindingFlags.Instance))
    {
        if (p.GetIndexParameters().Length > 0 || skipProps.Contains(p.Name)) continue;
        if (skipTypes.Contains(p.PropertyType)) continue;
        object pv;
        try { pv = p.GetValue(v); } catch { continue; }
        w.WritePropertyName(p.Name);
        try { WriteValue(w, pv, depth + 1, false); }
        catch (Exception e) { w.WriteStringValue("<error " + e.GetType().Name + ">"); }
    }
    w.WriteEndObject();
}

void Dump(string name, IEnumerable items)
{
    using var fs = File.Create(Path.Combine(outDir, name + ".json"));
    using var w = new Utf8JsonWriter(fs, new JsonWriterOptions { Indented = true, SkipValidation = true });
    w.WriteStartArray();
    foreach (var it in items) WriteValue(w, it, 0, true);
    w.WriteEndArray();
}

Dump("objects", Data.GameObjects);
Dump("rooms", Data.Rooms);
Dump("sprites", Data.Sprites);
Dump("sounds", Data.Sounds);
Dump("fonts", Data.Fonts);
Dump("scripts", Data.Scripts);
Dump("backgrounds", Data.Backgrounds);
Dump("extensions", Data.Extensions);
Dump("audiogroups", Data.AudioGroups ?? new List<UndertaleAudioGroup>());
Dump("texturepages", Data.TexturePageItems);
Dump("general", new object[] { Data.GeneralInfo, Data.Options });

// Embedded audio, named after the sound that uses it.
string audioDir = Path.Combine(outDir, "audio");
Directory.CreateDirectory(audioDir);
int n = 0;
foreach (var snd in Data.Sounds)
{
    if (snd?.AudioFile?.Data == null) continue;
    string ext = snd.File?.Content is string fn && Path.HasExtension(fn) ? Path.GetExtension(fn) : ".wav";
    File.WriteAllBytes(Path.Combine(audioDir, snd.Name.Content + ext), snd.AudioFile.Data);
    n++;
}
Console.WriteLine($"ExportMeta: wrote JSON + {n} embedded audio files to {outDir}");
