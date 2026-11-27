function Draw_EXP() {
    var X = argument0;
    var Y = argument1;
    var S = argument2;
    var per = clamp(expa / expa_next_level, 0, 1);
    draw_set_font(F1);
    draw_set_halign(fa_right);
    draw_set_color(c_black);
    var prev_alp = draw_get_alpha();
    draw_set_alpha(draw_get_alpha() / 2);
    for (var i = 0; i < 2; i++)
    {
        DT((X + (20 * A * S)) - (i * 2), Y - (52 * A * S) - (i * 2), L[40] + string(hero_level), 1 * S);
        DT((X + (20 * A * S)) - (i * 2), Y - (32 * A * S) - (i * 2), string(expa) + " / " + string(expa_next_level), 0.6 * S);
        draw_set_alpha(prev_alp);
        draw_set_color(c_white);
    }
    draw_set_alpha(prev_alp);
    draw_set_font(F0);
    draw_sprite_ext(__S(32), 3, X, Y, A * S, A * S, 0, c_white, _S);
    draw_set_alpha(_S);
    draw_rectangle(X - (200 * A * S), Y - (24 * A * S), X + (28 * A * S), Y, false);
    CS(16711935, _S / 2);
    draw_rectangle(X - (198 * A * S), Y - (22 * A * S), X + (26 * A * S), Y - (2 * A * S), false);
    CS(16711935, _S);
    draw_rectangle(X - (198 * A * S), Y - (22 * A * S), (X - (198 * A * S)) + (224 * A * S * per), Y - (2 * A * S), false);
    draw_set_halign(fa_center);
    CS(-1, _S);
}
