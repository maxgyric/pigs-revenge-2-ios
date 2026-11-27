function Draw_Shop() {
    var type = V[2];
    if (type == 0)
    {
        var weapon_count = __c_array_height_2d(WPN);
        var X = 0;
        var Y = 0;
        draw_sprite_ext(__S(51), 0, 130 * A, CH - (120 * A), A * _S, A * _S, 0, c_white, _S);
        draw_sprite_ext(__S(51), 1, 130 * A, CH + (100 * A), A * _S, A * _S, 0, c_white, _S);
        DT(130 * A, CH - (80 * A), string(money), 1);
        DT(130 * A, CH + (140 * A), string(gold), 1);
        var all_bought = 1;
        for (var i = 0; i < weapon_count; i++)
        {
            if (weapon_avaible[i] == 0)
            {
                all_bought = 0;
            }
        }
        if (all_bought)
        {
            DT(CW, CH, L[46], 1);
        }
        for (var i = 0; i < weapon_count; i++)
        {
            if (weapon_avaible[i])
            {
                continue;
            }
            var pos_x = ((CW - (200 * A)) + (400 * X * A)) - (400 * V[3] * A);
            var pos_y = (CH - (120 * A)) + (80 * Y * A);
            var sw = (sprite_get_width(__S(WPN[i, 8])) / 2) * A * _S;
            var sh = (sprite_get_height(__S(WPN[i, 8])) / 2) * A * _S;
            var have_money = money >= WPN[i, 2] && gold >= WPN[i, 3];
            if (((abs(X) - abs(V[4])) < 2 && (abs(X) - abs(V[4])) > -1) || (pos_x > (190 * A) && pos_x < (W - (190 * A)) && abs(V[3] - V[4]) > 0.35))
            {
                if (BT(pos_x, pos_y, 50, !have_money, "", 1 + (sin(F / 5) / 8)) && abs(V[4] - V[3]) < 0.05)
                {
                    if (have_money)
                    {
                        money -= WPN[i, 2];
                        gold -= WPN[i, 3];
                        weapon_avaible[i] = 1;
                        PS(92);
                        V[5] = 1;
                        SaveAll();
                    }
                }
                draw_sprite_pos(__S(WPN[i, 8]), 0, pos_x - sw, pos_y - sh, pos_x + sw, pos_y - sh, pos_x + sw, pos_y + sh, pos_x - sw, pos_y + sh, _S - (!have_money * 0.7));
                SA(1);
                if (WPN[i, 3] == 0)
                {
                    var text = WPN[i, 1] + L[45] + string(WPN[i, 2]);
                    draw_sprite_ext(__S(51), 0, pos_x + (70 * A), pos_y + (8 * A), 0.35 * A * _S, 0.35 * A * _S, 0, c_white, _S);
                    DT(pos_x + (90 * A), pos_y - (8 * A), text, 0.8);
                }
                else
                {
                    var text = WPN[i, 1] + L[45] + string(WPN[i, 3]);
                    draw_sprite_ext(__S(51), 1, pos_x + (70 * A), pos_y + (8 * A), 0.35 * A * _S, 0.35 * A * _S, 0, c_white, _S);
                    DT(pos_x + (90 * A), pos_y - (8 * A), text, 0.8);
                }
                SA(0);
            }
            Y++;
            if (Y > 3)
            {
                X++;
                Y = 0;
            }
        }
        if (V[4] > 0)
        {
            if (BT(CW - (320 * A), CH, 49, 0, "", 1))
            {
                V[4]--;
            }
        }
        if (V[4] < (X - 1))
        {
            if (BT(W - (60 * A), CH, 49, 1, "", 1))
            {
                V[4]++;
            }
        }
        V[3] = lerp(V[3], V[4], 0.2);
        if (V[4] > 0)
        {
            while (V[4] > (X - 1))
            {
                V[4]--;
            }
        }
    }
    else if (type == 2)
    {
        var X = W1 - (200 * A);
        var Y = CH - (100 * A);
        DT(W - (300 * A), H - (150 * A), L[47] + "$" + string(money), 1);
        for (var i = 0; i < __c_array_height_2d(dress_avaible); i++)
        {
            var price = (i * 5000) + 1000;
            var str = "$" + string(price);
            var spi = 2;
            if (money < price)
            {
                spi = 1;
            }
            if (dress_avaible[i, 0] == 1)
            {
                str = L[84];
                spi = 0;
            }
            if (selected_dress == i)
            {
                str = L[85];
                spi = 0;
            }
            if (BT(X, Y, 50, spi, str, 1))
            {
                if (dress_avaible[i, 0] == 0 && money >= price)
                {
                    dress_avaible[i, 0] = 1;
                    selected_dress = i;
                    money -= price;
                    PS(92);
                    SaveAll();
                }
                else if (dress_avaible[i, 0] == 1)
                {
                    selected_dress = i;
                    SaveAll();
                }
            }
            draw_sprite_ext(__S(dress_avaible[i, 1]), 0, X, Y, 0.4 * A, 0.4 * A, 0, c_white, _S);
            X += (120 * A);
            if (i == 3 || i == 5)
            {
                X = W1 - (200 * A);
                Y += (100 * A);
            }
        }
    }
    else if (type == 1)
    {
        var X = W1 - (200 * A);
        var Y = CH - (100 * A);
        DT(W - (300 * A), H - (150 * A), L[47] + "$" + string(money), 1);
        for (var i = 0; i < __c_array_height_2d(hat_avaible); i++)
        {
            var price = (i * 3000) + 1000;
            var str = "$" + string(price);
            var spi = 2;
            if (money < price)
            {
                spi = 1;
            }
            if (hat_avaible[i, 0] == 1)
            {
                str = L[84];
                spi = 0;
            }
            if (selected_hat == i)
            {
                str = L[85];
                spi = 0;
            }
            if (BT(X, Y, 50, spi, str, 1))
            {
                if (hat_avaible[i, 0] == 0 && money >= price)
                {
                    hat_avaible[i, 0] = 1;
                    selected_hat = i;
                    money -= price;
                    PS(92);
                    SaveAll();
                }
                else if (hat_avaible[i, 0] == 1)
                {
                    selected_hat = i;
                    SaveAll();
                }
            }
            if (i != 0)
            {
                var spw = (sprite_get_width(__S(hat_avaible[i, 1])) / 2) * A * 0.5;
                var sph = (sprite_get_height(__S(hat_avaible[i, 1])) / 2) * A * 0.5;
                draw_sprite_pos(__S(hat_avaible[i, 1]), 0, X - spw, Y - sph, X + spw, Y - sph, X + spw, Y + sph, X - spw, Y + sph, _S);
            }
            X += (120 * A);
            if (i == 3 || i == 5)
            {
                X = W1 - (200 * A);
                Y += (100 * A);
            }
        }
    }
    else if (type == 3)
    {
        var pos_y = CH - (50 * A);
        var sc = A * 0.8;
        draw_sprite_ext(__S(51), 0, CW - (200 * A), H - (180 * A), sc, sc, 0, c_white, _S);
        DT(CW - (200 * A), H - (145 * A), L[61] + string(money), 0.75);
        draw_sprite_ext(__S(51), 1, CW + (200 * A), H - (180 * A), sc, sc, 0, c_white, _S);
        DT(CW + (200 * A), H - (145 * A), L[61] + string(gold), 0.75);
        draw_sprite_ext(__S(51), 0, CW - (200 * A), pos_y - (50 * A), sc, sc, 0, c_white, _S);
        DT(CW - (200 * A), pos_y - (5 * A), "1,000,000", 1);
        draw_sprite_ext(__S(51), 1, CW + (200 * A), pos_y - (50 * A), sc, sc, 0, c_white, _S);
        DT(CW + (200 * A), pos_y - (5 * A), "1", 1);
        if (money >= 1000000)
        {
            if (BT(CW, pos_y - (50 * A), 53, 0, L[59], 1))
            {
                money -= 1000000;
                gold++;
                SaveAll();
            }
        }
        else
        {
            DT(CW, pos_y - (50 * A), L[60], 0.6);
        }
    }
}
