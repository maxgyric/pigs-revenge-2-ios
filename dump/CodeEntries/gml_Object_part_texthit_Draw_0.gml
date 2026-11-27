draw_set_font(F1);
var stt;
if (its_crit == 0 && powerup_hint == -1)
{
    stt = "-" + string(sc);
    if (combo_x_s > 2)
    {
        stt += ("#COMBO X" + string(combo_x_s));
    }
}
else if (powerup_hint == -1)
{
    stt = "CRITICAL HIT!#-" + string(sc);
}
else
{
    stt = G.L[148 + powerup_hint];
}
draw_text_transformed_colour(x + 1, y + 1, stt, image_xscale / 2, image_xscale / 2, 0, c_black, c_black, c_black, c_black, image_alpha);
draw_text_transformed_colour(x, y, stt, image_xscale / 2, image_xscale / 2, 0, col, col, col, col, image_alpha * 2);
draw_set_font(F0);
