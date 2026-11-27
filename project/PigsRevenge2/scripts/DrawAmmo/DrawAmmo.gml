function DrawAmmo() {
    var wp = WPN[current_weapon, 0];
    if (wp > 6 || (wp == 4 && instance_exists(player)))
    {
        var myp = instance_nearest(0, 0, player);
        myp.show_ammo = lerp(myp.show_ammo, 1, 0.35);
        if (myp.reloading_time < 0)
        {
            var AM = myp.ammo_in_slot[myp.selected_slot];
            switch (wp)
            {
                case 13:
                case 27:
                    spp = 183;
                    break;
                case 14:
                case 15:
                case 17:
                    spp = 181;
                    break;
                case 16:
                case 19:
                case 22:
                case 24:
                case 25:
                case 26:
                case 30:
                    spp = 180;
                    break;
                case 18:
                    spp = 183;
                    break;
                case 20:
                    spp = 182;
                    break;
                case 29:
                    spp = 179;
                    break;
                case 33:
                    spp = 178;
                    break;
                case 34:
                    spp = 177;
                    break;
                case 28:
                    spp = 184;
                    break;
                default:
                    spp = 175;
                    break;
            }
            var sp_w = sprite_get_width(__S(spp)) * 0.75 * A;
            var Y = 0;
            var X = 0;
            if (wp != 31 && wp != 32 && wp != 4)
            {
                repeat (AM)
                {
                    if (Y > 2)
                    {
                        break;
                    }
                    draw_sprite_ext(__S(spp), 0, (CW - (180 * A)) + (X * sp_w), (H - (80 * A)) + (sin((F / 5) + (X / 2)) * 4 * A) + (Y * sp_w * 1.2 * A), A, A, 0, c_white, 0.85 * _S * myp.show_ammo);
                    X++;
                    if (X > 20)
                    {
                        X = 0;
                        Y++;
                    }
                }
            }
            if (wp == 4 || wp == 32)
            {
                repeat (ceil(AM / 15))
                {
                    if (X > 6)
                    {
                        break;
                    }
                    draw_sprite_ext(__S(185), 0, (CW - (180 * A)) + (X * 60 * A), (H - (80 * A)) + (sin((F / 5) + (X / 2)) * 4 * A) + (Y * sp_w * 1.2 * A), A, A, 0, c_white, 0.85 * _S * myp.show_ammo);
                    X++;
                }
            }
        }
        else
        {
            var percent = (1 - (myp.reloading_time / G.WPN[G.current_weapon, 7])) * 7;
            for (var i = 0; i < percent; i += 1)
            {
                CS(0, _S / 2);
                draw_circle((CW - (150 * A)) + (i * 50 * A), H - (100 * A), 16 * A, 0);
                CS(-1, _S);
                draw_circle((CW - (150 * A)) + (i * 50 * A), H - (100 * A), 12 * A, 0);
                CS(-1, _S);
            }
            DT(CW, H - (50 * A), "RELOADING", 1);
        }
    }
}
