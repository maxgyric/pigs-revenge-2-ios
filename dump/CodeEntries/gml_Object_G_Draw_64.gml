AllowPress = !adm_open;
if (!(M == 12 || M == 13))
{
    if (F_b == 0 || keyboard_check_pressed(vk_f1))
    {
        V_b[0] = make_colour_hsv(250, 255, 210);
        V_b[1] = 0;
        V_b[2] = make_colour_hsv(45, 255, 255);
        sz = floor(CW / 2);
        for (var i = 0; i < sz; i++)
        {
            part_b[i, 0] = irandom(W - (CW / 2));
            part_b[i, 1] = H + random(CH);
            part_b[i, 2] = irandom_range(-3, 7);
            part_b[i, 3] = irandom_range(-1, -8);
            part_b[i, 4] = 0.75;
        }
    }
    CS(-1, 1);
    draw_rectangle_colour(0, 0, W, H, c_black, c_black, V_b[0], V_b[0], 0);
    draw_set_color(c_orange);
    var X = W - (130 * A);
    var Y = H - (260 * A);
    draw_sprite_ext(sp_fbloom, 0, X, Y, A * 3, A * 3, 0, c_yellow, 1);
    draw_circle(X, Y, 50 * A, 0);
    CS(0, 1);
    draw_sprite_ext(sp_slide_cloud, 0, CW - (460 * A), 120 * A, A, A, 0, c_black, 0.3);
    draw_sprite_ext(sp_slide_cloud, 0, CW - (180 * A), 180 * A, A, A, 0, c_black, 0.3);
    draw_sprite_ext(sp_slide_cloud, 0, CW + (350 * A), 80 * A, A, A, 0, c_black, 0.3);
    draw_sprite_ext(sp_slide_cloud, 0, CW + (110 * A), 190 * A, A, A, 0, c_black, 0.3);
    draw_ellipse(CW - (200 * A), H - (220 * A), W + (200 * A), H + (120 * A), 0);
    draw_ellipse(-150 * A, H - (150 * A), CW + (100 * A), H + (60 * A), 0);
    var XX = W - (130 * A);
    var YY = H - (200 * A);
    var SC = A * 1.7;
    draw_sprite_ext(sp_grassback, 0, XX, YY, SC, SC, -10, c_white, 1);
    draw_sprite_ext(sp_grassback, 0, XX - (110 * A), YY - (18 * A), SC, SC, 0, c_white, 1);
    draw_sprite_ext(sp_grassback, 0, XX - (280 * A), YY, SC, SC, 0, c_white, 1);
    XX = CW - (130 * A);
    YY = H - (160 * A);
    draw_sprite_ext(sp_grassback, 0, XX, YY, SC, SC, -10, c_white, 1);
    draw_sprite_ext(sp_grassback, 0, XX - (110 * A), YY - (18 * A), SC, SC, 0, c_white, 1);
    draw_sprite_ext(sp_grassback, 0, XX - (280 * A), YY, SC, SC, 0, c_white, 1);
    var pos_x = W - (300 * A);
    var pos_y = H - (275 * A);
    var pa = sin(F_b / 5) * 3 * A;
    draw_sprite_ext(sp_pl_foot0, 0, pos_x + (30 * A), pos_y + (60 * A), -A, A, 0, c_white, 1);
    draw_sprite_ext(sp_pl_foot0, 0, pos_x - (40 * A), pos_y + (60 * A), -A, A, 0, c_white, 1);
    draw_sprite_ext(sp_pl_foot1, 0, pos_x + (30 * A), pos_y + (60 * A), -A, A, 0, c_white, 1);
    draw_sprite_ext(sp_pl_foot1, 0, pos_x - (40 * A), pos_y + (60 * A), -A, A, 0, c_white, 1);
    var spp = dress_avaible[selected_dress, 1];
    draw_sprite_ext(spp, 0, pos_x, pos_y + pa, -A, A, 0, c_white, 1);
    pos_y -= (30 * A);
    var ind = 0;
    if (V_b[1] > 50)
    {
        ind = 1;
    }
    if (V_b[1] > 60)
    {
        V_b[1] = 0;
    }
    V_b[1]++;
    draw_sprite_ext(sp_pl_head0, 0, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    draw_sprite_ext(sp_pl_mouth, 0, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    draw_sprite_ext(sp_pl_mouth, 1, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    if (ind == 0)
    {
        draw_sprite_ext(sp_pl_eyes, 0, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
        draw_sprite_ext(sp_pl_eyes, 1, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(sp_pl_eyes, 2, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    }
    spp = hat_avaible[selected_hat, 1];
    if (selected_hat != 0)
    {
        draw_sprite_ext(spp, 0, pos_x, pos_y + (pa / 2), -A, A, 0, c_white, 1);
    }
    pos_y += (6 * A);
    if (current_weapon == 4 || (current_weapon > 13 && current_weapon != 18 && current_weapon != 23 && current_weapon != 29 && current_weapon != 32))
    {
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (50 * A), pos_y + (pa / 2) + (40 * A), A * 1.5, A * 1.5, 4, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (50 * A), pos_y + (pa / 2) + (40 * A), A, A, 0, c_white, 1);
        draw_sprite_ext(sp_pl_hand1, 0, pos_x + (30 * A), pos_y + (pa / 2) + (30 * A), A, A, 0, c_white, 1);
    }
    else if (current_weapon == 32 || current_weapon == 29 || current_weapon == 23 || current_weapon == 18)
    {
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (50 * A), pos_y + (pa / 2) + (40 * A), A * 1.5, A * 1.5, 10, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (50 * A), pos_y + (pa / 2) + (40 * A), A, A, 0, c_white, 1);
        draw_sprite_ext(sp_pl_hand1, 0, pos_x + (30 * A), pos_y + (pa / 2) + (30 * A), A, A, 0, c_white, 1);
    }
    else if (current_weapon > 6)
    {
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (20 * A), pos_y + (pa / 2) + (20 * A), -A * 1.5, A * 1.5, -10, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (20 * A), pos_y + (pa / 2) + (20 * A), -A, A, 0, c_white, 1);
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (10 * A), pos_y + (pa / 2) + (20 * A) + (10 * A), -A * 1.5, A * 1.5, -10, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (10 * A), pos_y + (pa / 2) + (20 * A) + (10 * A), -A, A, 0, c_white, 1);
    }
    else if (current_weapon != 6)
    {
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (40 * A), pos_y + (pa / 2) + (24 * A), -A, A, 0, c_white, 1);
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (42 * A), pos_y + (pa / 2) + (20 * A), -A * 1.5, A * 1.5, -75, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x - (35 * A), pos_y + (pa / 2) + (35 * A), -A, A, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(WPN[current_weapon, 8], 0, pos_x - (42 * A), pos_y + (pa / 2) + (20 * A), -A * 1.5, A * 1.5, -15, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, pos_x + (35 * A), pos_y + (pa / 2) + (35 * A), -A, A, 0, c_white, 1);
    }
    CS(V_b[2], 1);
    var sz = array_height_2d(part_b);
    for (var i = 0; i < sz; i++)
    {
        part_b[i, 0] += part_b[i, 2] * A;
        part_b[i, 1] += part_b[i, 3] * A;
        part_b[i, 4] -= random(0.0075) * (A * 2);
        part_b[i, 2] += random_range(-2.2, 3);
        part_b[i, 2] = clamp(part_b[i, 2], -6, 6);
        draw_set_alpha(part_b[i, 4]);
        if (part_b[i, 1] < (H + 20))
        {
            draw_line(part_b[i, 0], part_b[i, 1], part_b[i, 0] + (part_b[i, 2] * A), part_b[i, 1] + (part_b[i, 3] * A));
        }
        if (part_b[i, 4] < 0 || part_b[i, 0] < 0 || part_b[i, 0] > W || part_b[i, 1] < 0)
        {
            part_b[i, 0] = irandom(W - (CW / 2));
            part_b[i, 1] = H + random(CH);
            part_b[i, 2] = irandom_range(-3, 7);
            part_b[i, 3] = irandom_range(-1, -8);
            part_b[i, 4] = 0.75;
        }
    }
    CS(-1, 1);
    if (M == 3 && _S > 0.95 && hero_level > 0)
    {
        Draw_EXP(W - (100 * A), H - (130 * A), 1);
    }
    F_b++;
}
else
{
    part_b = 0;
    v_b = 0;
    F_b = 0;
}
if (weath_t != 0 && (M == 12 || M == 13))
{
    if (weath_f == 0)
    {
        if (weath_t == 3 || weath_t == 4)
        {
            weath_v[0] = make_color_hsv(random(255), 50 + (100 * (weath_t == 4)), 155 - (100 * (weath_t == 4)));
        }
        if (weath_t == 5)
        {
            for (var i = 0; i < 40; i++)
            {
                weath_v[i, 0] = random(W);
                weath_v[i, 1] = random(H);
            }
        }
    }
    if (weath_t == 1 || weath_t == 2)
    {
        var X = 0;
        var Y = 0;
        draw_set_alpha(0.7);
        draw_set_color(c_white);
        repeat (ceil(15 * weath_t * A))
        {
            X = random(W);
            Y = random(H);
            draw_line(X + 4, Y - 16, X - 4, Y + 16);
        }
        repeat (ceil(30 * weath_t * A))
        {
            X = random(W);
            Y = random(H);
            draw_ellipse(X, Y, X - 4, Y - 2, 1);
        }
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_sprite_ext(sp_fog, 0, CW, CH, 0.005 * W, 0.00909090909090909 * H, 0, c_dkgray, 0.4 * weath_t);
    }
    if (weath_t == 3 || weath_t == 4)
    {
        draw_set_alpha(0.3);
        draw_set_color(weath_v[0]);
        draw_rectangle(0, 0, W, H, false);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_sprite_ext(sp_fog, 0, CW, CH, 0.005 * W, 0.00909090909090909 * H, 0, weath_v[0], 0.4);
    }
    if (weath_t == 5)
    {
        var cnt = array_height_2d(weath_v);
        for (var i = 0; i < cnt; i++)
        {
            draw_sprite_ext(sp_snowfall, 0, weath_v[i, 0], weath_v[i, 1], A, A, weath_v[i, 1], c_white, 0.5);
            weath_v[i, 0] += random_range(0, 4);
            weath_v[i, 1] += 6;
            if (weath_v[i, 0] > (W + 32))
            {
                weath_v[i, 0] = 0;
            }
            if (weath_v[i, 1] > (H + 32))
            {
                weath_v[i, 1] = 0;
            }
        }
        draw_sprite_ext(sp_fog, 0, CW, CH, 0.005 * W, 0.00909090909090909 * H, 0, c_white, 0.4);
    }
    if (weath_t == 6)
    {
        draw_sprite_ext(sp_fog, 0, CW, CH, 0.005 * W, 0.00909090909090909 * H, 0, c_orange, 0.5);
        draw_set_color(c_orange);
        draw_set_alpha(0.15);
        var sc = A * 5;
        repeat (10)
        {
            draw_sprite_ext(sp_fbloom, 0, random(W), random(H), sc, sc, 0, c_orange, 0.15);
        }
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
    weath_f++;
}
else
{
    weath_f = 0;
    weath_v = 0;
}
if (M == 12 || M == 13)
{
    if (weath_time < 1)
    {
        draw_sprite_ext(sp_fog, 0, CW, CH, 0.005 * W, 0.00909090909090909 * H, 0, c_black, 0.8);
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_rectangle(0, 0, W, H, false);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_sprite_ext(sp_fbloom, 0, CW, CH, A * 10, A * 10, 0, c_white, 0.4);
    }
    else if (weath_time > 4 && weath_time < 10)
    {
        draw_set_alpha(0.1);
        draw_set_color(c_aqua);
        draw_rectangle(0, 0, W, H, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
if (M == 0)
{
    if (F == 0)
    {
        V[0] = 40;
        V[1] = 0;
        V[2] = 1;
        v[3] = 0;
        PS(0);
    }
    var a_a = V[1] * V[2];
    CS(0, 1);
    draw_rectangle(0, 0, W, H, false);
    CS(255, a_a);
    draw_sprite_ext(sp_logo2, 0, CW - (35 * A) - (V[0] * A), CH, A, A, 0, c_white, a_a);
    draw_sprite_ext(sp_logo2, 0, CW - (35 * A) - (V[0] * A), CH, -A, A, 0, c_white, a_a);
    draw_sprite_ext(sp_logo2, 0, CW + (35 * A) + (V[0] * A), CH, A, A, 0, c_white, a_a);
    draw_sprite_ext(sp_logo2, 0, CW + (35 * A) + (V[0] * A), CH, -A, A, 0, c_white, a_a);
    draw_sprite_ext(sp_logo1, 0, CW, CH + (V[0] * A), A, A, 0, c_white, a_a);
    V[3] = 100 * A * (1 - (V[0] / 40));
    draw_line(CW - V[3], CH, CW + V[3], CH);
    CS(-1, 1);
    V[0] *= 0.7;
    if (V[1] < 1)
    {
        V[1] += 0.1;
    }
    if (F > 45)
    {
        V[2] -= 0.1;
    }
    F++;
    if (F > 60 || mouse_check_button_pressed(mb_any))
    {
        audio_stop_sound(snd_startup);
        mouse_clear(mb_any);
        NextMenu(3);
        cacheInterstitial();
    }
}
if (M == 1)
{
    if (F == 0)
    {
        V[0] = "Credits###";
        V[1] = 0;
        v[2] = 0;
        V[3] = 0;
    }
    if (F == 0)
    {
        for (var i = 0; i < 10; i++)
        {
            var rep = irandom_range(5, 15);
            V[0] = V[0] + choose("Random guys", "Director", "Lead designer", "Cats", "Graphics", "Code", "Voice", "PR", "Story", "Testing", "Neighbors", "Concept artists", "Animation", "Game design") + "##";
            repeat (rep)
            {
                V[0] = V[0] + choose("Fred", "Boris", "Scott", "Jhonny", "Jack", "Matt", "Bobby", "Alisa", "Linda", "Grishka", "Mishka", "Vasek", "Adam", "Semen", "Tony", "Timmy") + " " + choose("Borisovich", "Jhonson", "Jackson", "Nikson", "Adams", "Bobston", "Semenich", "Stepanich", "Gibson", "Antonio", "Berns", "Pins", "Dash", "Pans", "Billy") + "#";
            }
            V[0] = V[0] + "##";
        }
    }
    SA(2);
    CS(0, 0.5 * _S);
    draw_rectangle(CW - (150 * A), 0, CW + (150 * A), H, false);
    CS(-1, _S);
    DT(CW, H - (V[1] * A), V[0], 0.8);
    SA(0);
    if (BT(W - (80 * A), H - (80 * A), 31, 0, L[1], 1) && V[2] == 0)
    {
        V[3] = 1;
    }
    V[1] += 2;
    if (keyboard_check(vk_down))
    {
        V[1] += 20;
    }
    if ((((string_height(V[0]) * 0.65) - V[1]) + H) < 0)
    {
        V[3] = 1;
    }
    if (V[3])
    {
        V[2] += 0.025;
        ach_map[10] = 1;
    }
    CS(0, V[2]);
    draw_rectangle(0, 0, W, H, false);
    CS(-1, 1);
    F++;
    if (V[2] > 1.1)
    {
        NextMenu(3);
    }
}
if (M == 2)
{
    if (F == 0)
    {
        V[0] = 0;
        V[1] = 0;
        V[2] = 100;
    }
    CS(0, 0.75 * _S);
    draw_rectangle(0, CH - (160 * A), W, CH + (160 * A), false);
    CS(-1, 1);
    SA(0);
    DT(CW, CH - (60 * A), L[2], 1);
    if (BT(CW - (130 * A) - (V[2] * A), CH + (60 * A), 60, 0, L[3], 0.5))
    {
        V[0] = 1;
        _Sout = 0.99;
    }
    if (BT(CW + (130 * A) + (V[2] * A), CH + (60 * A), 33, 0, L[4], 1))
    {
        V[0] = 0;
        _Sout = 0.99;
    }
    V[2] *= 0.8;
    F++;
    if (V[0] == 1)
    {
        V[1] += 0.03;
    }
    CS(0, V[1]);
    draw_rectangle(0, 0, W, H, false);
    CS(-1, 1);
    if (V[1] > 1.1)
    {
        game_end();
    }
    if (TReady && V[0] != 1)
    {
        NextMenu(3);
    }
}
if (M == 3)
{
    if (F == 0)
    {
        V[0] = 0;
    }
    draw_logogame(300 * A, CH - (75 * A), 0.8);
    for (var i = 0; i < 7; i++)
    {
        if (BT(W - (60 * A) - (60 * i * A), H - (50 * A), 30, i, "", 0.8))
        {
            LangLoad(i);
            gamelang = i;
            SaveAll();
        }
    }
    if (BT(W - (60 * A), 60 * A, 33, 0, L[5], 0.75))
    {
        _Sout = 0.99;
        V[0] = 2;
    }
    if (BT(W - (150 * A), 60 * A, 33, 2, "", 0.75))
    {
        music = !music;
        SaveAll();
    }
    if (BT(W - (240 * A), 60 * A, 33, 1, "", 0.75))
    {
        sounds = !sounds;
        if (sounds)
        {
            audio_play_sound(snd_button, 1, false);
        }
        SaveAll();
    }
    if (!music)
    {
        for (var i = 0; i < 4; i++)
        {
            draw_sprite_ext(sp_noavaible0, 0, W - (150 * A), 60 * A, 0.75 * A, 0.75 * A, 90 * i, c_white, _S);
        }
    }
    if (!sounds)
    {
        for (var i = 0; i < 4; i++)
        {
            draw_sprite_ext(sp_noavaible0, 0, W - (240 * A), 60 * A, 0.75 * A, 0.75 * A, 90 * i, c_white, _S);
        }
    }
    if (BT(140 * A, CH + (80 * A), 32, 0, L[6], 0.9))
    {
        _Sout = 0.99;
        V[0] = 5;
    }
    if (BT(300 * A, CH + (80 * A), 32, 1, L[7], 0.9))
    {
        _Sout = 0.99;
        V[0] = 8;
    }
    if (BT(460 * A, CH + (80 * A), 32, 2, L[8], 0.9))
    {
        _Sout = 0.99;
        V[0] = 7;
    }
    if (BT(300 * A, CH + (180 * A), 29, 0, L[9], 0.75))
    {
        _Sout = 0.99;
        V[0] = 4;
    }
    if (BT(60 * A, 40 * A, 34, 0, "", 0.5))
    {
        url_open("https://vk.com/exotika.games");
    }
    if (BT(120 * A, 40 * A, 34, 2, "", 0.5))
    {
        url_open("http://www.youtube.com/user/AlexStavXS/videos");
    }
    F++;
    if (TReady)
    {
        NextMenu(V[0]);
    }
}
if (M == 4 || M == 5 || M == 6 || M == 7 || M == 8)
{
    if (F == 0)
    {
        V[0] = 3;
        V[1] = 0;
        V[2] = 0;
        V[3] = 0;
        V[4] = 0;
        V[5] = 0;
        V[6] = selected_slot;
        V[7] = WPN[selected_slot];
        V[8] = 0;
        V[9] = 0;
        check_ach = 1;
        OpenLevelList(0);
    }
    if (!(V[2] != 2 && V[2] != 1))
    {
        V[8] = lerp(V[8], 0, 0.2);
    }
    else
    {
        V[8] = lerp(V[8], 1, 0.2);
    }
    CS(0, 0.85 * _S * V[8]);
    draw_rectangle(0, 0, W, H, false);
    CS(0, 0.37 * _S);
    draw_rectangle(0, H, W, H - (100 * A), false);
    CS(-1, 1);
    if (BT(60 * A, H - (60 * A), 31, 0, L[1], 1))
    {
        _Sout = 0.99;
        V[0] = 3;
    }
    SA(1);
    var st = 0;
    switch (M)
    {
        case 4:
            st = 16;
            break;
        case 5:
            st = 13;
            break;
        case 6:
            st = 15;
            break;
        case 7:
            st = 12;
            break;
        case 8:
            st = 14;
            break;
    }
    draw_text_ext_transformed_colour(60 * A, 60 * A, L[st], 32, 9999, A, A, 0, 16777215, 16777215, 16777215, 16777215, _S * 0.8);
    SA(0);
    if (M != 4)
    {
        if (BT(60 * A, H - (60 * A), 31, 0, L[1], 1))
        {
            _Sout = 0.99;
            V[0] = 3;
        }
        if (M != 5)
        {
            if (BT(160 * A, H - (60 * A), 32, 0, L[6], 0.6))
            {
                _Sout = 0.99;
                V[0] = 5;
            }
        }
        if (M != 8)
        {
            if (BT(260 * A, H - (60 * A), 32, 1, L[7], 0.6))
            {
                _Sout = 0.99;
                V[0] = 8;
            }
        }
        if (M != 6)
        {
            if (BT(W - (160 * A), H - (60 * A), 31, 4, L[11], 1))
            {
                _Sout = 0.99;
                V[0] = 6;
            }
        }
        if (M != 7)
        {
            if (BT(CW, H - (60 * A), 32, 2, L[8], 0.6))
            {
                _Sout = 0.99;
                V[0] = 7;
            }
        }
        if (V[5])
        {
            draw_sprite_ext(sp_lookhere, 0, (W - (230 * A)) + (sin(F) * 10), H - (60 * A), A, A, 0, c_white, _S);
            draw_set_font(F1);
            DT(W - (340 * A), H - (58 * A), L[50], 1);
            draw_set_font(F0);
        }
    }
    if (M == 4)
    {
        if (BT(W - (60 * A), H - (60 * A), 31, 1, L[10], 1))
        {
            _Sout = 0.99;
            V[0] = 1;
        }
    }
    if (M == 8)
    {
        for (var i = 0; i < 4; i++)
        {
            if (V[2] == i)
            {
                draw_set_alpha(_S / 2);
            }
            if (BT((CW - (200 * A)) + (i * 150 * A), 50 * A, 48, i, L[41 + i], 1))
            {
                V[2] = i;
                V[3] = 0;
            }
            CS(-1, _S);
        }
        Draw_Shop();
    }
    else
    {
        V[5] = 0;
    }
    if (M == 6)
    {
        Draw_Equip();
    }
    if (M == 4)
    {
        Draw_Ach();
    }
    if (M == 7)
    {
        Draw_Upgrade();
    }
    if (M == 5)
    {
        Draw_Levels();
    }
    F++;
    if (TReady)
    {
        if (!V[1])
        {
            NextMenu(V[0]);
        }
        else
        {
            MakeLoad(12);
        }
    }
}
else
{
    OpenLevelList(1);
}
if (M == 9)
{
    if (F == 0)
    {
        V[0] = 0;
        V[1] = 30;
        V[2] = random_range(26, 36);
        V[3] = 1;
        V[4] = 0;
        V[5] = 0;
        V[6] = 0;
        showInterstitial();
    }
    if (H > 700 && aver_fps > 27)
    {
        if (V[0] > 0.8 && !V[5])
        {
            V[5] = 1;
            showInterstitial();
            show_debug_message("Show!");
        }
    }
    CS(255, 0.25 * _S);
    draw_rectangle(0, 0, W, H, false);
    CS(255, _S);
    if (V[0] > 0.1)
    {
        draw_rectangle(20 * A, H - (20 * A), (20 * A) + ((W * clamp(V[0], 0, 1)) - (40 * A)), H - (40 * A), false);
    }
    CS(-1, _S);
    draw_logogame(CW, CH - (64 * A), 1);
    var tex = L[147] + string(play_level + 1) + "#" + L[V[2]];
    if (play_level >= max_levels || NextMenuAfterLoading != 12)
    {
        tex = L[V[2]];
    }
    draw_text_ext_transformed_colour(CW + (V[1] * A), CH + (130 * A), tex, 35, 9999, A, A, 0, 16777215, 16777215, 16777215, 16777215, _S - (abs(V[1]) / 30));
    if (!cutscene_show)
    {
        V[0] += choose(0.003, 0.05, 0.005, 0.0025, 0.015);
    }
    if (V[0] < 1.3)
    {
        V[1] = lerp(V[1], 0, 0.1);
    }
    else
    {
        V[1] = lerp(V[1], -90, 0.1);
    }
    if (V[0] > 1.5 && _Sout == 1)
    {
        _Sout = 0.99;
    }
    F++;
    if (V[3] != 0 && V[0] > 1.4 && NextMenuAfterLoading == 12)
    {
        var shit = play_level;
        while (shit >= 10)
        {
            shit -= 10;
        }
        if (shit == 0 && play_level != 0)
        {
            cutscene_show = 1;
        }
        cutscene_type = V[3];
    }
    if (TReady && V[0] > 1.8)
    {
        NextMenu(NextMenuAfterLoading);
        if (NextMenuAfterLoading == 12)
        {
            GameInit();
        }
    }
}
if (M == 10 || M == 11)
{
    if (F == 0)
    {
        V[0] = 0;
        V[1] = make_colour_hsv(0, 255, 80);
        StopAllMusic();
        cacheInterstitial();
    }
    var colcol = 32768;
    if (M == 11)
    {
        colcol = V[1];
    }
    CS(colcol, 1);
    draw_rectangle(0, 0, W, H, false);
    CS(0, 0.3);
    draw_rectangle(0, CH - (170 * A), W, CH + (150 * A), false);
    CS(colcol, 1);
    if (M == 11)
    {
        draw_sprite_ext(sp_bloodscreen, 0, 0, H, A, A, 0, c_red, 1);
        draw_sprite_ext(sp_bloodscreen, 0, W, 0, -A, -A, 0, c_red, 1);
    }
    CS(-1, 1);
    if (M == 10)
    {
        if (BT(W - (80 * A), H - (80 * A), 31, 3, L[17], 1))
        {
            _Sout = 0.99;
            V[0] = 12;
            play_level++;
        }
    }
    if (M == 11)
    {
        if (BT(W - (80 * A), H - (80 * A), 31, 6, L[18], 1))
        {
            _Sout = 0.99;
            V[0] = 12;
        }
    }
    if ((play_level + 1) > max_levels)
    {
        play_level = max_levels;
        V[0] = 1;
    }
    if (BT(CW - (150 * A), H - (80 * A), 32, 1, L[7], 0.6))
    {
        _Sout = 0.99;
        V[0] = 8;
    }
    if (BT(CW, H - (80 * A), 32, 2, L[8], 0.6))
    {
        _Sout = 0.99;
        V[0] = 7;
    }
    if (BT(CW + (150 * A), H - (80 * A), 31, 4, L[11], 1))
    {
        _Sout = 0.99;
        V[0] = 6;
    }
    if (BT(80 * A, H - (80 * A), 31, 0, L[19], 1))
    {
        _Sout = 0.99;
        V[0] = 5;
    }
    var tex = L[72];
    if (M == 10)
    {
        tex = L[73];
    }
    var ttt = floor(battle_time);
    var mins = 0;
    while (ttt > 59)
    {
        mins++;
        ttt -= 60;
    }
    if (ttt < 10)
    {
        ttt = "0" + string(ttt);
    }
    ttt = string(mins) + ":" + string(ttt);
    tex = tex + string(ttt);
    if (M == 11)
    {
        draw_sprite_ext(sp_loose, 0, (CW - (200 * A)) + 5, (CH - (80 * A)) + 5, A * 0.7, A * 0.7, sin(F / 10) * 10, c_black, _S / 2);
        draw_sprite_ext(sp_loose, 0, CW - (200 * A), CH - (80 * A), A * 0.7, A * 0.7, sin(F / 10) * 10, c_white, _S);
    }
    else
    {
        var ind = 2;
        if (battle_time > 90)
        {
            ind = 0;
        }
        else if (battle_time > 60)
        {
            ind = 1;
        }
        draw_sprite_ext(sp_medal, got_medal, (CW - (200 * A)) + 5, CH + 5, A * 0.9, A * 0.9, 0, c_black, _S / 2);
        draw_sprite_ext(sp_medal, got_medal, CW - (200 * A), CH, A * 0.9, A * 0.9, 0, c_white, _S);
    }
    DT(CW, CH - (150 * A), tex, 1);
    SA(1);
    DT(CW + (50 * A), CH, L[74] + string(battle_kills) + L[75] + string(battle_money) + L[76] + string(frags) + string(L[77] + string(money)), 0.75);
    draw_sprite_ext(sp_res_icons, 0, CW + (25 * A), CH - (75 * A), 0.5 * A, 0.5 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_coin, F / 2, CW + (25 * A), CH - (35 * A), 0.5 * A, 0.5 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_icons, 0, CW + (35 * A), CH + (78 * A), 0.3 * A, 0.3 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_icons, 0, CW + (20 * A), CH + (78 * A), 0.5 * A, 0.5 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_icons, 0, CW + (5 * A), CH + (78 * A), 0.3 * A, 0.3 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_coin, F / 2, CW + (35 * A), CH + (118 * A), 0.3 * A, 0.3 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_coin, F / 2, CW + (20 * A), CH + (118 * A), 0.5 * A, 0.5 * A, 0, c_white, _S);
    draw_sprite_ext(sp_res_coin, F / 2, CW + (5 * A), CH + (118 * A), 0.3 * A, 0.3 * A, 0, c_white, _S);
    SA(0);
    F++;
    if (TReady)
    {
        MakeLoad(V[0]);
    }
}
if (M == 12 || M == 13)
{
    if (F == 0)
    {
        V[0] = 0;
        V[1] = -1;
        V[2] = -1;
        V[3] = 0;
        V[4] = 0;
    }
    if (V[4] > 9 && V[4] != 11)
    {
        if (V[4] == 10)
        {
            MPlay(1);
            V[4] = 11;
        }
    }
    else if (V[4] != 11)
    {
        V[4]++;
    }
    CS(0, _S / 2);
    if (M == 13)
    {
        draw_rectangle(0, 0, W, H, false);
    }
    else
    {
        draw_rectangle(0, 0, W, 60 * A, false);
    }
    CS(-1, 1);
    current_weapon = clamp(current_weapon, 0, array_height_2d(WPN) - 1);
    if (M == 12 && !instance_exists(part_deadplayer) && (!is_win || V[3] <= 300))
    {
        if (clamp(expa / expa_next_level, 0, 1) > 0.7 && (expa_next_level - expa) < (expa_next_level / 7))
        {
            Draw_EXP(W - (60 * A), 130 * A, 0.75);
        }
        Draw_Quest();
        Draw_Powerups();
        battle_time += (1 * (delta_time / 1000000));
        var sc = A * 0.5;
        var XADD = 475 * A;
        draw_sprite_ext(sp_res_icons, 0, (-150 * A) + XADD, 30 * A, sc, sc, 0, c_white, _S);
        draw_sprite_ext(sp_res_coin, F / 2, XADD, 30 * A, sc, sc, 0, c_white, _S);
        SA(1);
        DT((-135 * A) + XADD, 27 * A, battle_kills, 0.75);
        DT((15 * A) + XADD, 27 * A, battle_money, 0.75);
        SA(0);
        var ttt = floor(battle_time);
        var mins = 0;
        while (ttt > 59)
        {
            mins++;
            ttt -= 60;
        }
        if (ttt < 10)
        {
            ttt = "0" + string(ttt);
        }
        ttt = string(mins) + ":" + string(ttt);
        DT(240 * A, 30 * A, ttt, 0.75);
        for (var i = 0; i < 4; i++)
        {
            if (weapon_slot[i] == -1)
            {
                continue;
            }
            var pbx = 50 * A;
            var pby = (110 * A) + (i * 70 * A);
            var swid = (sprite_get_width(WPN[weapon_slot[i], 8]) / 3) * A * _S;
            var shid = (sprite_get_height(WPN[weapon_slot[i], 8]) / 3) * A * _S;
            its_slot = selected_slot == i;
            if (its_slot)
            {
                pbx -= (10 * A);
            }
            if (selected_slot != i)
            {
                if (BT(pbx, pby, 31, 2, "", 0.9))
                {
                    selected_slot = i;
                    current_weapon = weapon_slot[i];
                    if (WPN[current_weapon, 14] != -1)
                    {
                        PS(WPN[current_weapon, 14]);
                    }
                    with (player)
                    {
                        reloading_time = -1;
                        show_ammo = -1;
                    }
                }
            }
            var spp = WPN[weapon_slot[i], 8];
            draw_sprite_pos(spp, 0, pbx - swid, pby - shid, pbx + swid, pby - shid, pbx + swid, pby + shid, pbx - swid, pby + shid, _S - (its_slot / 2));
        }
        if (BT(W - (30 * A), 30 * A, 31, 7, "", 0.8))
        {
            V[0] = 13;
            _Sout = 0.99;
        }
        var pX = 180 * A;
        var pX2 = W - (180 * A);
        var pY = H - (150 * A);
        var sc0 = A;
        DrawAmmo();
        if (instance_exists(player) && (current_weapon != 0 && current_weapon != 1 && current_weapon != 2 && current_weapon != 3 && current_weapon != 5 && current_weapon != 6))
        {
            myp = instance_nearest(x, y, player);
            if (myp.reloading_time < 0 && myp.ammo_in_slot[myp.selected_slot] < G.WPN[G.current_weapon, 5] && myp.show_ammo > 0.5)
            {
                if (BT(330 * A, H - (80 * A), 46, 4, L[37], 0.6))
                {
                    myp.reloading_time = G.WPN[G.current_weapon, 7];
                }
            }
        }
        if (instance_exists(player))
        {
            var prev_a = draw_get_alpha();
            var prev_c = draw_get_color();
            myp = instance_nearest(0, 0, player);
            CS(255, _S * 0.75 * clamp((myp.immune / 60) - 0.5, 0, 1));
            draw_rectangle(0, 0, W, H, false);
            CS(prev_c, prev_a);
        }
        var min_sc = 40 * A;
        var max_sc = 100 * A;
        if (control_type_walk == 0)
        {
            if (!ready_walk)
            {
                with (player)
                {
                    speed *= 0.8;
                }
            }
            for (var i = 0; i < 4; i++)
            {
                draw_sprite_ext(sp_contr0, 0, pX, pY, sc0, sc0, 90 * i, c_white, _S);
            }
            for (var i = 0; i < 4; i++)
            {
                if (device_mouse_check_button(i, mb_any) && !device_mouse_check_button_pressed(i, mb_any))
                {
                    continue;
                }
                if (point_distance(pX, pY, device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) < max_sc && device_mouse_check_button_pressed(i, mb_any))
                {
                    device_walk = i;
                }
            }
        }
        if (device_walk != -1)
        {
            if (point_distance(pX, pY, device_mouse_x_to_gui(device_walk), device_mouse_y_to_gui(device_walk)) > min_sc)
            {
                ready_walk = 1;
                dir_walk = point_direction(pX, pY, device_mouse_x_to_gui(device_walk), device_mouse_y_to_gui(device_walk));
            }
            else
            {
                ready_walk = 0;
            }
        }
        else
        {
            ready_walk = 0;
        }
        if (control_type_walk == 1)
        {
            for (var i = 0; i < 4; i++)
            {
                draw_sprite_ext(sp_controls2, 0, pX, pY, sc0, sc0, 90 * i, c_white, _S);
            }
            if (v_keys_maked == 0)
            {
                v_keys[0] = virtual_key_add(pX - (16 * A), pY - (56 * A), 34 * A, 34 * A, 87);
                v_keys[1] = virtual_key_add(pX - (16 * A), pY + (24 * A), 34 * A, 34 * A, 83);
                v_keys[2] = virtual_key_add(pX - (56 * A), pY - (14 * A), 34 * A, 34 * A, 65);
                v_keys[3] = virtual_key_add(pX + (24 * A), pY - (14 * A), 34 * A, 34 * A, 68);
                v_keys[4] = virtual_key_add(pX + (24 * A), pY - (56 * A), 34 * A, 34 * A, 69);
                v_keys[5] = virtual_key_add(pX - (56 * A), pY - (56 * A), 34 * A, 34 * A, 81);
                v_keys[6] = virtual_key_add(pX + (24 * A), pY + (24 * A), 34 * A, 34 * A, 67);
                v_keys[7] = virtual_key_add(pX - (56 * A), pY + (24 * A), 34 * A, 34 * A, 90);
                v_keys_maked = 1;
            }
            if (!keyboard_check(ord("W")) && !keyboard_check(ord("S")) && !keyboard_check(ord("A")) && !keyboard_check(ord("D")) && !keyboard_check(ord("E")) && !keyboard_check(ord("Q")) && !keyboard_check(ord("C")) && !keyboard_check(ord("Z")))
            {
                with (player)
                {
                    speed *= 0.8;
                }
            }
        }
        else if (v_keys_maked)
        {
            v_keys_maked = 0;
            for (var i = 0; i < array_length_1d(v_keys); i++)
            {
                virtual_key_delete(v_keys[i]);
            }
        }
        if (control_type_walk == 2)
        {
            draw_sprite_ext(sp_controls3, 0, pX, pY, sc0, sc0, 0, c_white, _S);
            with (player)
            {
                if (abs(device_get_tilt_y()) >= 0.2 || abs(-0.5 + clamp(device_get_tilt_z(), 0, 1)) > 0.35)
                {
                    motion_add(90, (-0.5 + clamp(device_get_tilt_z(), 0, 1)) * 4);
                    motion_add(0, device_get_tilt_y() * 4);
                }
                else
                {
                    speed *= 0.8;
                }
            }
        }
        if (device_mouse_check_button_released(device_walk, mb_any))
        {
            device_walk = -1;
            ready_walk = 0;
        }
        if (control_type_shot == 0)
        {
            for (var i = 0; i < 2; i++)
            {
                draw_sprite_ext(sp_contr1, 0, pX2, pY, sc0, sc0, (i * 180) + 10, c_white, _S);
                draw_sprite_ext(sp_contr1, 0, pX2, pY, -sc0, sc0, (i * 180) + 10, c_white, _S);
            }
            for (var i = 0; i < 4; i++)
            {
                if (device_mouse_check_button(i, mb_any) && !device_mouse_check_button_pressed(i, mb_any))
                {
                    continue;
                }
                if (point_distance(pX2, pY, device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) < max_sc && device_mouse_check_button_pressed(i, mb_any))
                {
                    device_shot = i;
                }
            }
        }
        if (device_shot != -1)
        {
            if (point_distance(pX2, pY, device_mouse_x_to_gui(device_shot), device_mouse_y_to_gui(device_shot)) > min_sc)
            {
                ready_shot = 1;
                dir_shot = point_direction(pX2, pY, device_mouse_x_to_gui(device_shot), device_mouse_y_to_gui(device_shot));
            }
            else
            {
                ready_shot = 0;
            }
        }
        else
        {
            ready_shot = 0;
        }
        if (control_type_shot == 1)
        {
            draw_sprite_ext(sp_controls3, 1, pX2, pY, sc0, sc0, 0, c_white, _S);
            for (var i = 0; i < 4; i++)
            {
                if (i == device_walk)
                {
                    continue;
                }
                if (device_mouse_check_button_pressed(i, mb_any) && point_distance(pX, pY, device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) > max_sc && device_mouse_y_to_gui(i) > (80 * A) && !(device_mouse_x_to_gui(i) < (100 * A) && device_mouse_y_to_gui(i) < CH) && !(point_distance(330 * A, H - (80 * A), device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) < min_sc))
                {
                    device_shot = i;
                    ready_shot = 1;
                }
            }
            if (instance_exists(player))
            {
                myplayer = instance_nearest(0, 0, player);
                if (device_shot != -1)
                {
                    dir_shot = point_direction(myplayer.x, myplayer.y, device_mouse_x(device_shot), device_mouse_y(device_shot));
                }
            }
        }
        if (control_type_shot == 2)
        {
            draw_sprite_ext(sp_controls3, 2, pX2, pY, sc0, sc0, 0, c_white, _S);
        }
        if (device_mouse_check_button_released(device_shot, mb_any))
        {
            device_shot = -1;
            ready_shot = 0;
        }
        if (instance_exists(player))
        {
            myplayer = instance_nearest(0, 0, player);
            for (var i = 0; i < myplayer.hp; i++)
            {
                draw_sprite_ext(sp_gui_hp, 0, (35 * A) + (i * 60 * A), 30 * A, A, A, 0, c_white, _S);
                draw_sprite_ext(sp_gui_hp, 0, (35 * A) + (i * 60 * A), 30 * A, -A, A, 0, c_white, _S);
            }
        }
    }
    else
    {
        start_walk = 0;
        start_shot = 0;
        dir_walk = 0;
        dir_shot = 0;
        device_walk = -1;
        device_shot = -1;
        ready_shot = 0;
        ready_walk = 0;
        if (instance_exists(part_deadplayer) && M == 12)
        {
            draw_sprite_ext(sp_bloodscreen, 0, 0, H, A, A, 0, c_red, 1);
            draw_sprite_ext(sp_bloodscreen, 0, W, 0, -A, -A, 0, c_red, 1);
            draw_sprite_ext(sp_gui_blood, 0, CW, CH, A, A, 0, c_red, 1);
            V[1] += 0.05;
            CS(255, 0.5 * clamp(V[1], 0, 1));
            draw_rectangle(0, 0, W, H, false);
            draw_rectangle(0, CH - (120 * A), W, CH + (120 * A), false);
            CS(-1, _S * clamp(V[1], 0, 1));
            DT(CW, CH, L[25], 2);
            CS(-1, _S);
            StopAllMusic();
            mycorpse = instance_nearest(0, 0, part_deadplayer);
            if (mycorpse.to_die)
            {
                NextMenu(11);
                exit;
            }
        }
        if (is_win && M == 12 && (!instance_exists(enemy) || V[3] > 300))
        {
            if (V[2] == -1)
            {
                StopAllMusic();
                PS(3);
                OpenLevelList(0);
                if ((play_level + 1) < max_levels)
                {
                    if (level_stat[play_level + 1] == 0)
                    {
                        level_stat[play_level + 1] = 1;
                    }
                }
                if (level_stat[play_level] < (2 + got_medal))
                {
                    level_stat[play_level] = 2 + got_medal;
                }
                ini_open("S");
                for (var i = 0; i < max_levels; i++)
                {
                    ini_write_real("LEV", "L" + string(i), level_stat[i]);
                }
                ini_close();
                SaveAll();
                OpenLevelList(1);
            }
            V[2] += 0.1;
            CS(32768, clamp(V[2], 0, 1) / 2);
            draw_rectangle(0, CH - (150 * A), W, CH + (150 * A), false);
            CS(16777215, V[2]);
            DT(CW, CH, L[78], 1);
            CS(-1, _S);
            if (V[2] > 6)
            {
                NextMenu(10);
            }
        }
    }
    if (instance_exists(enemy) && is_win && M == 12)
    {
        V[3]++;
        if (V[3] < 300)
        {
            var pa = draw_get_alpha();
            draw_set_alpha(pa / 2);
            DT(CW, 160 * A, L[79] + string(10 - floor(V[3] / 30)) + L[57] + L[80], 1);
            draw_set_alpha(pa);
        }
    }
    if (!instance_exists(enemy))
    {
        V[3] = 99999;
    }
    if (M == 13)
    {
        if (BT(W - (60 * A), 60 * A, 31, 6, L[20], 1))
        {
            V[0] = 12;
            _Sout = 0.99;
        }
        if (BT(60 * A, 60 * A, 31, 5, L[19], 1))
        {
            V[0] = 5;
            _Sout = 0.99;
        }
        var sc = A * 0.5;
        DT(CW - (200 * A), CH - (150 * A), L[38], 1);
        DT(CW + (200 * A), CH - (150 * A), L[39], 1);
        SA(1);
        draw_sprite_ext(sp_res_icons, 0, CW - (215 * A) - (60 * A), CH - (100 * A), sc, sc, 0, c_white, _S);
        DT(CW - (200 * A) - (60 * A), CH - (100 * A), battle_kills, 0.75);
        draw_sprite_ext(sp_res_coin, F / 2, CW - (215 * A) - (60 * A), CH - (65 * A), sc, sc, 0, c_white, _S);
        DT(CW - (200 * A) - (60 * A), CH - (65 * A), battle_money, 0.75);
        draw_sprite_ext(sp_res_icons, 0, (CW + (170 * A)) - (60 * A), CH - (100 * A), sc / 2, sc / 2, 0, c_white, _S);
        draw_sprite_ext(sp_res_icons, 0, (CW + (185 * A)) - (60 * A), CH - (100 * A), sc, sc, 0, c_white, _S);
        DT((CW + (210 * A)) - (60 * A), CH - (100 * A), frags, 0.75);
        draw_sprite_ext(sp_res_icons, 0, (CW + (200 * A)) - (60 * A), CH - (100 * A), sc / 2, sc / 2, 0, c_white, _S);
        draw_sprite_ext(sp_res_coin, F / 2, (CW + (170 * A)) - (60 * A), CH - (65 * A), sc / 2, sc / 2, 0, c_white, _S);
        draw_sprite_ext(sp_res_coin, F / 2, (CW + (185 * A)) - (60 * A), CH - (65 * A), sc, sc, 0, c_white, _S);
        DT((CW + (210 * A)) - (60 * A), CH - (65 * A), money, 0.75);
        draw_sprite_ext(sp_res_coin, F / 2, (CW + (200 * A)) - (60 * A), CH - (65 * A), sc / 2, sc / 2, 0, c_white, _S);
        SA(0);
        Draw_EXP(CW + (200 * A), CH + (90 * A), 1);
        CS(16777215, clamp(sin(F / 3) * 5, 0.25, 1));
        DT(CW, 60 * A, L[21], 1);
        CS(-1, 1);
        SA(1);
        DT(40 * A, H - (100 * A), L[22], 0.75);
        if (BT(CW - (60 * A), H - (100 * A), 82, 0, "", 0.5))
        {
            control_type_walk = 0;
        }
        if (BT(CW + (60 * A), H - (100 * A), 82, 2, "", 0.5))
        {
            control_type_walk = 2;
        }
        var x_selected = CW - (60 * A);
        switch (control_type_walk)
        {
            case 1:
                x_selected = CW;
                break;
            case 2:
                x_selected = CW + (60 * A);
                break;
        }
        for (var i = 0; i < 4; i++)
        {
            draw_sprite_ext(sp_select_control, 0, x_selected, H - (100 * A), A * 0.5, A * 0.5, 90 * i, c_white, _S);
        }
        if (BT(50 * A, CH - (50 * A), 33, 2, "", 0.75))
        {
            music = !music;
        }
        if (BT(50 * A, CH + (50 * A), 33, 1, "", 0.75))
        {
            sounds = !sounds;
            if (sounds)
            {
                audio_play_sound(snd_button, 1, false);
            }
        }
        if (!music)
        {
            for (var i = 0; i < 4; i++)
            {
                draw_sprite_ext(sp_noavaible0, 0, 50 * A, CH - (50 * A), 0.75 * A, 0.75 * A, 90 * i, c_white, _S);
            }
        }
        if (!sounds)
        {
            for (var i = 0; i < 4; i++)
            {
                draw_sprite_ext(sp_noavaible0, 0, 50 * A, CH + (50 * A), 0.75 * A, 0.75 * A, 90 * i, c_white, _S);
            }
        }
        DT(40 * A, H - (50 * A), L[23], 0.75);
        if (BT(CW - (60 * A), H - (50 * A), 82, 0, "", 0.5))
        {
            control_type_shot = 0;
        }
        if (BT(CW, H - (50 * A), 82, 1, "", 0.5))
        {
            control_type_shot = 1;
        }
        if (BT(CW + (60 * A), H - (50 * A), 82, 2, "", 0.5))
        {
            control_type_shot = 2;
        }
        x_selected = CW - (60 * A);
        switch (control_type_shot)
        {
            case 1:
                x_selected = CW;
                break;
            case 2:
                x_selected = CW + (60 * A);
                break;
        }
        for (var i = 0; i < 4; i++)
        {
            draw_sprite_ext(sp_select_control, 0, x_selected, H - (50 * A), A * 0.5, A * 0.5, i * 90, c_white, _S);
        }
        SA(0);
        draw_set_halign(fa_right);
        DT(W - (10 * A), H - (100 * A), L[66 + control_type_walk], 0.75);
        DT(W - (10 * A), H - (50 * A), L[69 + control_type_shot], 0.75);
        SA(0);
    }
    F++;
    if (TReady)
    {
        if (V[0] == 5)
        {
            MakeLoad(V[0]);
        }
        else
        {
            NextMenu(V[0]);
        }
    }
}
if (M == 12)
{
    instance_activate_all();
}
else
{
    instance_deactivate_all(true);
}
if (!(M == 12 || M == 13))
{
    if (game_active)
    {
        GameDestroy();
    }
    v_keys_maked = 0;
    for (var i = 0; i < array_length_1d(v_keys); i++)
    {
        virtual_key_delete(v_keys[i]);
    }
}
if (hint_time > 0)
{
    hint_time--;
    hint_a = lerp(hint_a, 1, 0.1);
}
else
{
    hint_a = lerp(hint_a, 0, 0.1);
}
if (hint_a > 0 && M == 12)
{
    var pa = draw_get_alpha();
    var pc = draw_get_color();
    var sc = 0.7 * A;
    draw_set_alpha(0.5 * hint_a);
    draw_set_color(c_black);
    draw_rectangle(W1 - (40 * A), H2 - (30 * A), W2 + (40 * A), H2 + (30 * A), false);
    draw_set_alpha(hint_a);
    draw_set_color(c_white);
    draw_sprite_ext(sp_hint, 0, W1 - (40 * A), H2, A, A, 0, c_white, hint_a);
    draw_text_transformed(CW, H2, L[hint_mess], sc, sc, 0);
    draw_set_alpha(pa);
    draw_set_color(pc);
}
if (cutscene_show)
{
    CS(-1, 1);
    if (cutscene_f == 0)
    {
        cutscene_v[0] = 0;
        cutscene_v[1] = 0;
        cutscene_v[2] = make_colour_rgb(0, 128, 255);
        cutscene_v[3] = make_colour_rgb(80, 255, 70);
        cutscene_v[4] = choose(enemy_sprite_0, enemy_sprite_1, enemy_sprite_2);
        cutscene_v[5] = choose(enemy_sprite_0, enemy_sprite_1, enemy_sprite_2);
        cutscene_v[6] = choose(enemy_sprite_0, enemy_sprite_1, enemy_sprite_2);
        cutscene_v[7] = irandom_range(91, 100);
        cutscene_v[8] = irandom_range(101, 110);
        cutscene_v[9] = irandom_range(111, 120);
    }
    CS(8421504, 1);
    draw_rectangle(0, 0, W, H, false);
    switch (cutscene_f)
    {
        case 200:
            cutscene_v[0] = 1;
            break;
        case 400:
            cutscene_v[0] = 2;
            break;
    }
    var slide = cutscene_v[0];
    if (slide == 0 || slide == 2)
    {
        var color_sky = cutscene_v[2];
        var color_gro = cutscene_v[3];
        if (slide == 2)
        {
            color_sky = 0;
            color_gro = 255;
        }
        draw_set_colour(color_sky);
        draw_rectangle(0, 0, W, H2 - (40 * A), false);
        if (slide == 2)
        {
            var count = floor(W / 12);
            for (var i = 0; i < count; i++)
            {
                var sc = A + (clamp(sin(i) * A, 1, 5) / 2);
                draw_sprite_ext(sp_partfire, (F / 3) + (i * 3), (W / 12) * i, H2, sc, sc, 0, c_white, 1);
            }
        }
        draw_set_colour(color_gro);
        draw_rectangle(0, H2 - (40 * A), W, H, false);
        var cols = 16777215;
        if (slide == 2)
        {
            cols = 255;
        }
        draw_sprite_ext(sp_slide_mountains0, 0, W2, H2 - (40 * A), A, A, 0, cols, 1);
        draw_sprite_ext(sp_slide_sun, 0, W1 - (40 * A), H1, A, A, cutscene_f * 2, c_white, 1);
        draw_sprite_ext(sp_slide_cloud, 0, W1 - (190 * A), H1 + (35 * A), A, A, 0, cols, 0.8);
        draw_sprite_ext(sp_slide_cloud, 0, CW, H1 - (40 * A), A, A, 0, cols, 0.8);
        draw_sprite_ext(sp_slide_cloud, 0, W2 + (220 * A), H1 + (30 * A), A, A, 0, cols, 0.8);
        var X = W1 + (50 * A);
        var Y = H2;
        var S = A;
        draw_sprite_ext(sp_fbloom, 0, X, Y + (10 * A), S * 4, S, 0, c_black, 1);
        draw_sprite_ext(sp_pl_foot0, 0, X - (35 * S), Y, S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_foot0, 0, X + (35 * S), Y, S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_foot1, 0, X - (35 * S), Y, S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_foot1, 0, X + (35 * S), Y, S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_tail, 0, X - (60 * S), Y - (40 * S), S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, X + (35 * A), Y - (55 * A), S, S, -45, c_white, 1);
        draw_sprite_ext(dress_avaible[selected_dress, 1], 0, X, Y - (60 * S), S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_hand0, 0, X - (55 * A), Y - (55 * A), S, S, -30, c_white, 1);
        draw_sprite_ext(sp_pl_head0, 0, X, Y - (80 * S), S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_eyes, 0, X, Y - (80 * S), S, S, 0, c_white, 1);
        draw_sprite_ext(sp_pl_eyes, 1, X, Y - (80 * S), S, S, 0, c_white, 1);
        if (slide == 0)
        {
            draw_sprite_ext(sp_pl_mouth2, 0, X, Y - (80 * S), S, S, 0, make_color_rgb(218, 130, 139), 1);
        }
        else
        {
            draw_sprite_ext(sp_pl_mouth, 0, X, Y - (80 * S), S, S, 0, c_white, 1);
            draw_sprite_ext(sp_pl_mouth, 1, X, Y - (80 * S), S, S, 0, c_white, 1);
        }
        if (selected_dress != 0)
        {
            draw_sprite_ext(hat_avaible[selected_hat, 1], 0, X, Y - (80 * S), S, S, 0, c_white, 1);
        }
        if (slide == 2)
        {
            var count = floor(W / 8);
            for (var i = 0; i < count; i++)
            {
                var sc = A + (clamp(sin(i) * A, 1, 5) / 2);
                draw_sprite_ext(sp_partfire, (F / 3) + (i * 5), (W / 8) * i, H, sc, sc, 0, c_white, 0.5);
            }
        }
    }
    if (slide == 1)
    {
        CS(128, 1);
        draw_rectangle(0, 0, W, CH, false);
        CS(0, 1);
        draw_rectangle(0, H, W, CH, false);
        draw_sprite_ext(sp_lotenemies, 0, W, CH, A, A, 0, c_white, 1);
        for (var i = 0; i < 3; i++)
        {
            var fr = cutscene_f / 2;
            var x_plus = (15 * i * A) - ((cutscene_f - 50) * A);
            var y_plus = 30 * i * A;
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + i, (W2 - (40 * A)) + (60 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (120 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + (210 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + (i * 3), (W2 - (40 * A)) + (260 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (300 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], (fr / 2) + i, (W2 - (40 * A)) + (140 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], fr / 2, (W2 - (40 * A)) + (180 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + i, (W2 - (40 * A)) + (210 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (250 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + (280 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + (i * 3), (W2 - (40 * A)) + (300 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (330 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], (fr / 2) + i, (W2 - (40 * A)) + (370 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], fr / 2, (W2 - (40 * A)) + (400 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + i, (W2 - (40 * A)) + (440 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (480 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], fr, (W2 - (40 * A)) + (510 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[6], (fr / 2) + (i * 3), (W2 - (40 * A)) + (570 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[4], (fr / 2) + (i * 2), (W2 - (40 * A)) + (600 * A) + x_plus, CH + y_plus, -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], (fr / 2) + i, (W2 - (40 * A)) + (630 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
            draw_sprite_ext(cutscene_v[5], fr / 2, (W2 - (40 * A)) + (670 * A) + x_plus, CH + y_plus + (20 * A), -A, A, 0, c_white, 1);
        }
        var sc = (A * 1.5) + (sin(cutscene_f) / 6);
        draw_sprite_ext(sp_slide_warn, 0, W1 - (90 * A), CH, sc, sc, 0, c_white, 1);
    }
    if (cutscene_f < 50)
    {
        cutscene_v[1] = lerp(cutscene_v[1], 1, 0.12);
    }
    if (cutscene_f > 550)
    {
        cutscene_v[1] = lerp(cutscene_v[1], 0, 0.12);
    }
    CS(0, 0.75);
    draw_rectangle(0, 0, W, 100 * A * cutscene_v[1], false);
    draw_rectangle(0, H, W, H - (100 * A * cutscene_v[1]), false);
    CS(0, 1 - cutscene_v[1]);
    draw_rectangle(0, 0, W, H, false);
    CS(16777215, 0.5 * cutscene_v[1]);
    draw_text_ext_transformed(CW, 20 * A * cutscene_v[1], L[141], 0, 9999, A, A, 0);
    draw_set_alpha(1 * cutscene_v[1]);
    var aaa = 7;
    switch (slide)
    {
        case 0:
            aaa = 7;
            break;
        case 1:
            aaa = 8;
            break;
        case 2:
            aaa = 9;
            break;
    }
    draw_text_ext_transformed(CW, H - (60 * A * cutscene_v[1]), L[cutscene_v[aaa]], 0, 9999, A, A, 0);
    if (mouse_check_button_pressed(mb_any))
    {
        cutscene_f += 99999;
    }
    cutscene_f++;
    if (cutscene_f > 570)
    {
        cutscene_show = 0;
    }
    CS(-1, _S);
}
else
{
    cutscene_f = 0;
    cutscene_type = 0;
    cutscene_v = 0;
}
if (keyboard_check(ord("N")))
{
    level_up_x = 1;
}
if (level_up_x > 0 && level_up_x < 590)
{
    if (level_up_x < 299.8)
    {
        level_up_x = lerp(level_up_x, 300, 0.1);
    }
    else
    {
        level_up_x += ((level_up_x - 299.7) / 2);
    }
    var pos_x = (CW - (300 * A)) + (level_up_x * A);
    var alp = 1 - (abs(abs(level_up_x) - 300) / 250);
    draw_sprite_ext(sp_levelup, 0, pos_x, 100 * A, A, A, 0, c_white, alp);
    var prev_a = draw_get_alpha();
    draw_set_alpha(alp);
    draw_sprite_ext(sp_levelup2, 0, pos_x - (260 * A), 90 * A, A / 2, A / 2, (F * 3) + 20, c_yellow, alp);
    draw_sprite_ext(sp_levelup2, 0, pos_x - (270 * A), 130 * A, A / 2, A / 2, -F * 3, c_red, alp);
    draw_sprite_ext(sp_levelup2, 0, pos_x + (200 * A), 170 * A, A, A, (F * 3) + 80, c_lime, alp);
    draw_sprite_ext(sp_levelup2, 0, pos_x - (50 * A), 240 * A, A, A, (-F * 5) + 30, c_aqua, alp);
    draw_set_font(F1);
    var st_ = L[81] + string(hero_level);
    draw_text_ext_transformed_colour(pos_x + (1 * A), 121 * A, st_, 0, 9999, A, A, 0, 16711935, 16711935, 16711935, 16711935, alp);
    draw_text_ext_transformed_colour(pos_x, 120 * A, st_, 0, 9999, A, A, 0, 16776960, 16776960, 16776960, 16776960, alp);
    draw_set_font(F0);
    draw_set_alpha(prev_a);
}
draw_set_alpha(1);
draw_set_color(c_white);
var _amx = window_mouse_get_x();
var _amy = window_mouse_get_y();
var _arel = mouse_check_button_released(mb_any);
var _aingame = game_active && (M == 12 || M == 13);
var _abx1 = 0;
var _aby1 = 0;
var _abw = max(120, 120 * A);
var _abh = max(64, 60 * A);
var _ashow = 0;
var _aalpha = 0.75;
var _apad = max(8, 10 * A);
var _atop = max(64, 64 * A);
var _arows = 8;
var _acols = 2;
var _abh2 = 0;
var _abw2 = 0;
var _ahit = -1;
var _ai = 0;
var _acol = 0;
var _arow = 0;
var _ax1 = 0;
var _ay1 = 0;
var _ax2 = 0;
var _ay2 = 0;
var _alab = "";
var _aon = -1;
var _aen = 1;
var _aclr = 0;
var _ats = 1;
var _aseg = 0;
var _ak = 0;
var _asx1 = 0;
var _asx2 = 0;
var _aspd = "x1";
draw_set_font(F0);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (adm_open && !(M == 3 || M == 12 || M == 13))
{
    adm_open = 0;
}
if (!adm_open)
{
    if (M == 3)
    {
        _abx1 = 160 * A;
        _aby1 = 8 * A;
        _ashow = 1;
    }
    if (M == 12 && game_active && !is_win && !instance_exists(part_deadplayer))
    {
        _abw = max(100, 100 * A);
        _abh = max(56, 50 * A);
        _abx1 = W - (85 * A) - _abw;
        _aby1 = 4 * A;
        _aalpha = 0.35;
        _ashow = 1;
    }
    if (M == 13 && game_active)
    {
        _abx1 = 10 * A;
        _aby1 = 125 * A;
        _ashow = 1;
    }
    if (_ashow)
    {
        draw_set_alpha(_aalpha);
        draw_set_colour(make_color_rgb(150, 30, 30));
        draw_rectangle(_abx1, _aby1, _abx1 + _abw, _aby1 + _abh, false);
        draw_set_colour(c_white);
        draw_rectangle(_abx1, _aby1, _abx1 + _abw, _aby1 + _abh, true);
        draw_set_alpha(min(1, _aalpha + 0.3));
        draw_text_transformed(_abx1 + (_abw / 2), _aby1 + (_abh / 2), "ADMIN", min(1, (_abw - 10) / max(1, string_width("ADMIN"))), min(1, (_abw - 10) / max(1, string_width("ADMIN"))), 0);
        draw_set_alpha(1);
        if ((_arel && point_in_rectangle(_amx, _amy, _abx1, _aby1, _abx1 + _abw, _aby1 + _abh)) || keyboard_check_pressed(vk_f1))
        {
            adm_open = 1;
            adm_lev = play_level;
            adm_reset = 0;
            _arel = 0;
            mouse_clear(mb_any);
            if (M == 12)
            {
                NextMenu(13);
            }
        }
    }
}
else if (keyboard_check_pressed(vk_f1))
{
    adm_open = 0;
    _arel = 0;
}
if (adm_open)
{
    while (_arows > 4 && (((H - _atop - _apad) / _arows) - _apad) < 64)
    {
        _arows -= 2;
    }
    _acols = ceil(16 / _arows);
    _abh2 = clamp(((H - _atop - _apad) / _arows) - _apad, 64, 130);
    _abw2 = (W - (_apad * (_acols + 1))) / _acols;
    if (room_speed == 15)
    {
        _aspd = "x0.5";
    }
    if (room_speed == 60)
    {
        _aspd = "x2";
    }
    draw_set_alpha(0.85);
    draw_set_colour(c_black);
    draw_rectangle(0, 0, W, H, false);
    draw_set_alpha(1);
    draw_set_colour(c_yellow);
    _ats = min(1.4, (_atop * 0.7) / max(1, string_height("A")));
    draw_text_transformed(W / 4, _atop / 2, "АДМІН-МЕНЮ", _ats, _ats, 0);
    draw_set_colour(c_white);
    if (adm_msg_t > 0)
    {
        draw_set_colour(c_lime);
        draw_text_transformed((W * 3) / 4, _atop / 2, adm_msg, _ats * 0.75, _ats * 0.75, 0);
        draw_set_colour(c_white);
    }
    else
    {
        draw_text_transformed((W * 3) / 4, _atop / 2, "гроші " + string(money) + "  рівень героя " + string(hero_level), _ats * 0.6, _ats * 0.6, 0);
    }
    for (_ai = 0; _ai < 16; _ai += 1)
    {
        _acol = _ai div _arows;
        _arow = _ai % _arows;
        _ax1 = _apad + (_acol * (_abw2 + _apad));
        _ay1 = _atop + (_arow * (_abh2 + _apad));
        _ax2 = _ax1 + _abw2;
        _ay2 = _ay1 + _abh2;
        _alab = "";
        _aon = -1;
        _aen = 1;
        _aclr = make_color_rgb(45, 80, 150);
        switch (_ai)
        {
            case 0:
                _alab = "Нескінченні гроші";
                _aon = adm_money;
                break;
            case 1:
                _alab = "Відкрити все";
                break;
            case 2:
                _alab = "Безсмертя";
                _aon = adm_god;
                break;
            case 3:
                _alab = "Нескінченні набої";
                _aon = adm_ammo;
                break;
            case 4:
                _alab = "Вбивство з 1 удару";
                _aon = adm_onehit;
                break;
            case 5:
                _alab = "Заморозити ворогів";
                _aon = adm_freeze;
                break;
            case 6:
                _alab = "Швидкість гри: " + _aspd;
                break;
            case 7:
                _alab = "FPS і вороги на екрані";
                _aon = adm_fps;
                break;
            case 8:
                _alab = "+1 рівень героя (зараз " + string(hero_level) + ")";
                break;
            case 9:
                _alab = "Рівень " + string(adm_lev + 1);
                break;
            case 10:
                _alab = "Грати рівень " + string(adm_lev + 1);
                _aclr = make_color_rgb(40, 130, 60);
                break;
            case 11:
                _alab = "Виграти рівень";
                _aen = _aingame && !is_win;
                break;
            case 12:
                _alab = "Хвиля ворогів +10";
                _aen = _aingame && !is_win;
                break;
            case 13:
                _alab = "Викликати боса";
                _aen = _aingame && !is_win;
                break;
            case 14:
                _alab = "Скинути прогрес";
                if (adm_reset > 0)
                {
                    _alab = "Точно? Натисни ще раз";
                }
                _aclr = make_color_rgb(160, 50, 40);
                _aen = !game_active;
                break;
            case 15:
                _alab = "Закрити";
                _aclr = make_color_rgb(90, 90, 90);
                break;
        }
        if (_aon == 1)
        {
            _aclr = make_color_rgb(40, 140, 60);
            _alab = _alab + ": ВКЛ";
        }
        else if (_aon == 0)
        {
            _aclr = make_color_rgb(70, 70, 80);
            _alab = _alab + ": ВИКЛ";
        }
        if (_ai == 9)
        {
            _aseg = _abw2 / 6;
            for (_ak = 0; _ak < 5; _ak += 1)
            {
                _asx1 = _ax1 + (_ak * _aseg);
                if (_ak > 2)
                {
                    _asx1 += _aseg;
                }
                _asx2 = (_asx1 + _aseg) - 4;
                if (_ak == 2)
                {
                    _asx2 = (_asx1 + (_aseg * 2)) - 4;
                }
                draw_set_colour(make_color_rgb(45, 80, 150));
                if (_ak == 2)
                {
                    draw_set_colour(make_color_rgb(25, 25, 35));
                }
                draw_rectangle(_asx1, _ay1, _asx2, _ay2, false);
                draw_set_colour(c_white);
                draw_rectangle(_asx1, _ay1, _asx2, _ay2, true);
                switch (_ak)
                {
                    case 0:
                        _alab = "-10";
                        break;
                    case 1:
                        _alab = "-1";
                        break;
                    case 2:
                        _alab = "Рівень " + string(adm_lev + 1);
                        break;
                    case 3:
                        _alab = "+1";
                        break;
                    case 4:
                        _alab = "+10";
                        break;
                }
                _ats = min((_abh2 * 0.5) / max(1, string_height("A")), (_asx2 - _asx1 - 8) / max(1, string_width(_alab)));
                draw_text_transformed((_asx1 + _asx2) / 2, (_ay1 + _ay2) / 2, _alab, _ats, _ats, 0);
                if (_arel && _ak != 2 && point_in_rectangle(_amx, _amy, _asx1, _ay1, _asx2, _ay2))
                {
                    switch (_ak)
                    {
                        case 0:
                            adm_lev -= 10;
                            break;
                        case 1:
                            adm_lev -= 1;
                            break;
                        case 3:
                            adm_lev += 1;
                            break;
                        case 4:
                            adm_lev += 10;
                            break;
                    }
                    adm_lev = clamp(adm_lev, 0, max_levels - 1);
                }
            }
        }
        else
        {
            if (!_aen)
            {
                draw_set_alpha(0.3);
            }
            draw_set_colour(_aclr);
            draw_rectangle(_ax1, _ay1, _ax2, _ay2, false);
            draw_set_colour(c_white);
            draw_rectangle(_ax1, _ay1, _ax2, _ay2, true);
            _ats = min((_abh2 * 0.5) / max(1, string_height("A")), (_abw2 - 16) / max(1, string_width(_alab)));
            draw_text_transformed((_ax1 + _ax2) / 2, (_ay1 + _ay2) / 2, _alab, _ats, _ats, 0);
            draw_set_alpha(1);
            if (_aen && _arel && point_in_rectangle(_amx, _amy, _ax1, _ay1, _ax2, _ay2))
            {
                _ahit = _ai;
            }
        }
    }
    if (_ahit != -1)
    {
        adm_msg_t = 75;
        adm_msg = "";
        if (_ahit != 14)
        {
            adm_reset = 0;
        }
    }
    switch (_ahit)
    {
        case 0:
            adm_money = !adm_money;
            if (adm_money)
            {
                money = max(money, 999999);
                gold = max(gold, 999999);
                SaveAll();
                adm_msg = "Гроші: 999999";
            }
            else
            {
                adm_msg = "Гроші більше не доливаються";
            }
            break;
        case 1:
            for (_ai = 0; _ai < array_height_2d(WPN); _ai += 1)
            {
                weapon_avaible[WPN[_ai, 0]] = 1;
                for (_ak = 0; _ak < 4; _ak += 1)
                {
                    UW_map[_ai, _ak] = 4;
                }
            }
            for (_ai = 0; _ai < 10; _ai += 1)
            {
                dress_avaible[_ai, 0] = 1;
            }
            for (_ai = 0; _ai < 8; _ai += 1)
            {
                hat_avaible[_ai, 0] = 1;
            }
            for (_ai = 0; _ai < 20; _ai += 1)
            {
                ach_map[_ai] = 1;
            }
            OpenLevelList(0);
            for (_ai = 0; _ai < max_levels; _ai += 1)
            {
                if (level_stat[_ai] == 0)
                {
                    level_stat[_ai] = 1;
                }
            }
            ini_open("S");
            for (_ai = 0; _ai < max_levels; _ai += 1)
            {
                ini_write_real("LEV", "L" + string(_ai), level_stat[_ai]);
            }
            ini_close();
            OpenLevelList(1);
            SaveAll();
            adm_msg = "Відкрито: зброя, апгрейди, костюми, рівні";
            break;
        case 2:
            adm_god = !adm_god;
            break;
        case 3:
            adm_ammo = !adm_ammo;
            break;
        case 4:
            adm_onehit = !adm_onehit;
            break;
        case 5:
            adm_freeze = !adm_freeze;
            if (!adm_freeze)
            {
                pwrup[3] = 0;
            }
            break;
        case 6:
            if (room_speed == 30)
            {
                room_speed = 60;
            }
            else if (room_speed == 60)
            {
                room_speed = 15;
            }
            else
            {
                room_speed = 30;
            }
            break;
        case 7:
            adm_fps = !adm_fps;
            break;
        case 8:
            hero_level += 1;
            expa = 0;
            expa_next_level = ceil(expa_next_level * 1.2);
            SaveAll();
            adm_msg = "Рівень героя " + string(hero_level);
            break;
        case 10:
            adm_open = 0;
            play_level = adm_lev;
            selected_stage = adm_lev div 10;
            MakeLoad(12);
            break;
        case 11:
            instance_activate_all();
            with (enemy)
            {
                instance_destroy();
            }
            is_win = 1;
            got_medal = 2;
            adm_open = 0;
            NextMenu(12);
            break;
        case 12:
            instance_activate_all();
            repeat (10)
            {
                _ax1 = (view_xview[0] - 30) + random(view_wview[0] + 60);
                _ay1 = (view_yview[0] - 30) + random(view_hview[0] + 60);
                if (choose(0, 1))
                {
                    _ax1 = choose(view_xview[0] - 30, view_xview[0] + view_wview[0] + 30);
                }
                else
                {
                    _ay1 = choose(view_yview[0] - 30, view_yview[0] + view_hview[0] + 30);
                }
                instance_create(_ax1, _ay1, enemy);
            }
            adm_open = 0;
            NextMenu(12);
            break;
        case 13:
            instance_activate_all();
            _ak = instance_create(view_xview[0] + (view_wview[0] / 2), view_yview[0] - 60, enemy);
            with (_ak)
            {
                sprite[0] = G.enemy_sprite_3;
                sprite[1] = G.enemy_sprite_3a;
                sw = (sprite_get_width(sprite[0]) / 2) * scale;
                sh = (sprite_get_height(sprite[0]) / 2) * scale;
                image_speed = sprite_get_number(sprite[0]) / 10;
                hp_start *= 60;
                hp = hp_start;
                prev_hp = hp;
                reward *= 5;
                scale *= 1.8;
                color = make_color_rgb(255, 50, 50);
                imboss = 1;
                sw *= 1.5;
                sh *= 1.5;
            }
            adm_open = 0;
            NextMenu(12);
            break;
        case 14:
            if (adm_reset > 0)
            {
                adm_reset = 0;
                ini_open("S");
                ini_section_delete("LEV");
                ini_section_delete("weapons");
                ini_section_delete("weapons_");
                ini_close();
                money = 0;
                gold = 0;
                frags = 0;
                expa = 0;
                expa_next_level = 50;
                total_time = 0;
                hero_level = 0;
                selected_dress = 0;
                selected_hat = 0;
                selected_stage = 0;
                play_level = 0;
                adm_lev = 0;
                for (_ai = 0; _ai < 10; _ai += 1)
                {
                    dress_avaible[_ai, 0] = 0;
                }
                for (_ai = 0; _ai < 8; _ai += 1)
                {
                    hat_avaible[_ai, 0] = 0;
                }
                dress_avaible[0, 0] = 1;
                hat_avaible[0, 0] = 1;
                for (_ai = 0; _ai < 20; _ai += 1)
                {
                    ach_map[_ai] = 0;
                }
                for (_ai = 0; _ai < array_height_2d(WPN); _ai += 1)
                {
                    weapon_avaible[WPN[_ai, 0]] = 0;
                    for (_ak = 0; _ak < 4; _ak += 1)
                    {
                        UW_map[_ai, _ak] = 0;
                    }
                }
                weapon_avaible[0] = 1;
                weapon_avaible[14] = 1;
                weapon_slot[0] = 0;
                weapon_slot[1] = 14;
                weapon_slot[2] = -1;
                weapon_slot[3] = -1;
                selected_slot = 0;
                current_weapon = 0;
                adm_money = 0;
                SaveAll();
                adm_msg = "Прогрес скинуто";
            }
            else
            {
                adm_reset = 90;
                adm_msg = "Натисни ще раз, щоб скинути";
            }
            break;
        case 15:
            adm_open = 0;
            break;
    }
    if (!adm_open)
    {
        mouse_clear(mb_any);
    }
}
if (adm_fps)
{
    _alab = "FPS " + string(fps) + "  ворогів " + string(instance_number(enemy)) + "  room_speed " + string(room_speed);
    draw_set_halign(fa_left);
    draw_set_alpha(0.6);
    draw_set_colour(c_black);
    draw_rectangle(4, H - (34 * A) - 8, 12 + (string_width(_alab) * 0.7 * A), H - 4, false);
    draw_set_alpha(1);
    draw_set_colour(c_yellow);
    draw_text_transformed(8, H - (17 * A) - 6, _alab, 0.7 * A, 0.7 * A, 0);
}
draw_set_colour(c_white);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
