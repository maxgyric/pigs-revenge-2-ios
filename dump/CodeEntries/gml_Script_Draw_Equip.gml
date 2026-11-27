var slot = V[6];
for (var i = 0; i < 4; i++)
{
    var weapon_exists = weapon_slot[i] != -1;
    var pos_x = 80 * A;
    var pos_y = (CH - (100 * A)) + (75 * i * A);
    var spp, sw, sh, tex;
    if (weapon_exists)
    {
        spp = WPN[weapon_slot[i], 8];
        tex = L[51] + " " + string(i) + ": " + WPN[weapon_slot[i], 1];
        sw = (sprite_get_width(spp) / 3) * A * _S;
        sh = (sprite_get_height(spp) / 3) * A * _S;
    }
    var aa = 1 * _S;
    if (V[6] == i)
    {
        aa = _S * 0.5;
        pos_x -= (40 * A);
    }
    SA(1);
    CS(-1, aa);
    if (BT(pos_x, pos_y, 54, i, "", 1))
    {
        V[6] = i;
        SaveAll();
    }
    if (weapon_exists)
    {
        draw_sprite_pos(spp, 0, pos_x - sw, pos_y - sh, pos_x + sw, pos_y - sh, pos_x + sw, pos_y + sh, pos_x - sw, pos_y + sh, aa);
        DT(pos_x + (20 * A), pos_y + (20 * A), tex, 0.75);
    }
    CS(-1, _S);
    SA(0);
    if (!weapon_exists && slot == i)
    {
        DT(CW, CH - (100 * A), "Select weapon!", 1);
    }
}
var cnt_start = slot * 7;
var cnt_end = cnt_start + 7;
var X = 0;
var Y = 0;
var iter = 0;
if (slot != 0)
{
    cnt_end += 7;
    cnt_start += 7;
}
else
{
    cnt_end += 7;
}
for (var i = cnt_start; i < cnt_end; i++)
{
    var spp = WPN[i, 8];
    var sw = (sprite_get_width(spp) / 3) * A * _S;
    var sh = (sprite_get_height(spp) / 3) * A * _S;
    var pos_x = CW + (X * 60 * A);
    var pos_y = (H - (220 * A)) + (Y * 60 * A);
    var aa = _S - (0.75 * (weapon_slot[slot] == i));
    if (!weapon_avaible[i])
    {
        continue;
    }
    CS(-1, aa);
    if (BT(pos_x, pos_y, 54, slot, "", 1))
    {
        selected_slot = slot;
        weapon_slot[slot] = i;
        audio_stop_sound(WPN[i, 14]);
        if (WPN[i, 14] != -1)
        {
            PS(WPN[i, 14]);
        }
        else
        {
            PS(26);
        }
        SaveAll();
    }
    draw_sprite_pos(spp, 0, pos_x - sw, pos_y - sh, pos_x + sw, pos_y - sh, pos_x + sw, pos_y + sh, pos_x - sw, pos_y + sh, _S);
    CS(-1, _S);
    switch (iter)
    {
        case 0:
            X++;
            Y++;
            break;
        case 1:
            X++;
            Y--;
            break;
        case 2:
            X++;
            Y++;
            break;
        case 3:
            X++;
            Y--;
            break;
        case 4:
            X++;
            Y++;
            break;
        case 5:
            X++;
            Y--;
            break;
        case 6:
            X++;
            Y++;
            break;
        case 7:
            X = -1;
            Y -= 2;
            break;
        case 8:
            X += 2;
            break;
        case 9:
            X += 2;
            break;
        case 10:
            X += 2;
            break;
        case 11:
            X += 2;
            break;
        case 12:
            X = -1;
            Y = 1;
            break;
    }
    iter++;
}
if (weapon_slot[slot] != -1)
{
    var pos_x = CW + (200 * A);
    var pos_y = CH - (170 * A);
    var spp = WPN[weapon_slot[slot], 8];
    var sw = (sprite_get_width(spp) / 1.5) * A * _S;
    var sh = (sprite_get_height(spp) / 1.5) * A * _S;
    var tex = L[53] + string(WPN[weapon_slot[slot], 4]) + L[58] + string(WPN[weapon_slot[slot], 6] / 30) + L[54];
    if (WPN[weapon_slot[slot], 5] > 1)
    {
        tex = tex + L[55] + string(WPN[weapon_slot[slot], 5]);
    }
    if (WPN[weapon_slot[slot], 7] > 1)
    {
        tex = tex + L[56] + string(WPN[weapon_slot[slot], 7] / 30) + L[57];
    }
    draw_sprite_pos(spp, 0, (pos_x - sw) + 3, (pos_y - sh) + 3, pos_x + sw + 3, (pos_y - sh) + 3, pos_x + sw + 3, pos_y + sh + 3, (pos_x - sw) + 3, pos_y + sh + 3, _S);
    SA(2);
    DT(pos_x, pos_y - (90 * A), WPN[weapon_slot[slot], 1], 1);
    DT(pos_x, pos_y + (10 * A), tex, 0.75);
    SA(0);
}
