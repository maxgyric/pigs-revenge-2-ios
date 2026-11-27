function Draw_Ach() {
    var count = __c_array_length_1d(ach_map);
    var page = V[9];
    var X = CW - (150 * A) - (V[9] * 500 * A);
    var Y = H1;
    if (page > 0)
    {
        if (BT(100 * A, CH, 49, 0, "", 1))
        {
            V[9]--;
        }
    }
    if (page < 3)
    {
        if (BT(W - (100 * A), CH, 49, 1, "", 1))
        {
            V[9]++;
        }
    }
    DT(CW, H1 - (50 * A), L[142] + string(page + 1) + "/4", 1);
    draw_set_halign(fa_left);
    for (var i = 0; i < count; i++)
    {
        if (X > (CW - (300 * A)) && X < (CW + (300 * A)))
        {
            if (ach_map[i] == 0)
            {
                draw_sprite_ext(__S(59), 0, X, Y, A, A, 0, c_white, _S);
                draw_sprite_ext(__S(59), 0, X, Y, -A, A, 0, c_white, _S);
            }
            else
            {
                var sc = A * 0.35;
                draw_sprite_ext(__S(60), 0, X, Y, sc, sc, 0, c_lime, _S);
            }
            DT(X + (30 * A), Y, L[121 + i], 1);
        }
        Y += (50 * A);
        if (i == 5 || i == 11 || i == 17)
        {
            Y = H1;
            X += (500 * A);
        }
    }
    draw_set_halign(fa_center);
}
