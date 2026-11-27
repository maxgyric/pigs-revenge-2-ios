var wp = V[6];
var slot = V[6];
var weapon_selected = 0;
for (var i = 0; i < 4; i++)
{
    var weapon_exists = weapon_slot[i] != -1;
    pos_x = 80 * A;
    pos_y = (CH - (100 * A)) + (75 * i * A);
    var spp, sw, sh, tex;
    if (weapon_exists)
    {
        weapon_selected = 1;
        spp = WPN[weapon_slot[i], 8];
        tex = WPN[weapon_slot[i], 1];
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
    }
    if (weapon_exists)
    {
        draw_sprite_pos(spp, 0, pos_x - sw, pos_y - sh, pos_x + sw, pos_y - sh, pos_x + sw, pos_y + sh, pos_x - sw, pos_y + sh, aa);
        DT(pos_x + (20 * A), pos_y + (20 * A), tex, 0.5);
    }
    CS(-1, _S);
    SA(0);
    if (!weapon_exists && slot == i)
    {
        DT(CW, CH - (100 * A), "Select weapon!", 0.85);
    }
}
var pos_x = CW;
var pos_y = CH - (150 * A);
DT(CW, CH - (235 * A), L[47] + "$" + string(money), 0.85);
if (weapon_slot[slot] != -1)
{
    for (var i = 0; i < 4; i++)
    {
        var cur_wp = weapon_slot[slot];
        if (cur_wp < 7 && cur_wp != 4 && (i == 1 || i == 3))
        {
            continue;
        }
        if (cur_wp == 4 && i == 2)
        {
            continue;
        }
        if (cur_wp == 31 && i == 1)
        {
            continue;
        }
        if (cur_wp == 32 && i == 2)
        {
            continue;
        }
        var get_up = UW_map[cur_wp, i];
        var get_wp = WPN[weapon_slot[slot], 2] + (WPN[weapon_slot[slot], 3] * 100000);
        var price = 2000 + (get_up * 10 * get_wp);
        draw_set_halign(fa_left);
        var str = "$" + string(price);
        if (UW_map[cur_wp, i] >= 4)
        {
            str = L[86];
        }
        str = str + "#" + L[87 + i] + string(WPN[weapon_slot[slot], 4 + i]);
        if (i == 0 || i == 1)
        {
            if (UW_map[cur_wp, i] > 0)
            {
                str = str + "#" + "(+" + string(ceil((ceil(WPN[cur_wp, 4 + i] + UW_map[cur_wp, i]) / 3) * UW_map[cur_wp, i])) + ")";
            }
        }
        else if (UW_map[cur_wp, i] > 0)
        {
            str = str + "#" + "(-" + string(ceil(WPN[cur_wp, 4 + i] * UW_map[cur_wp, i]) / 6) + ")";
        }
        DT(CW + (280 * A), pos_y + (100 * i * A), str, 0.8);
        draw_set_halign(fa_center);
        if (UW_map[cur_wp, i] < 4)
        {
            if (BT(pos_x - (200 * A), pos_y + (100 * i * A), 55, i, L[62 + i], 1) && money > price)
            {
                UW_map[cur_wp, i] += 1;
                money -= price;
                PS(92);
                SaveAll();
            }
        }
        else
        {
            DT(pos_x - (200 * A), pos_y + (100 * i * A), L[86], 1);
        }
        for (var k = 0; k < 4; k++)
        {
            var ind = 0;
            var up = UW_map[cur_wp, i];
            if (up > k)
            {
                ind = 1;
            }
            draw_sprite_ext(sp_wpupstar, ind, (pos_x - (40 * A)) + (85 * k * A), pos_y + (100 * i * A), A, A, 0, c_white, _S);
        }
    }
}
