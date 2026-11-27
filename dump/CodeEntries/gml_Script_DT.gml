var X = argument0;
var Y = argument1;
var T = argument2;
var S = clamp(argument3 * G.A * 1.4, 0.2, 1) * _S;
var p_c = draw_get_color();
var p_a = draw_get_alpha();
var s_o = 2 * S;
var a_a = 0;
if (_S < 0.5)
{
    a_a = 1 - (_S / 2);
}
draw_set_colour(c_black);
draw_set_alpha((draw_get_alpha() * 0.3) - a_a);
draw_text_ext_transformed(X + s_o, Y + s_o, T, 38, 99999, S, S, 0);
draw_set_colour(p_c);
draw_set_alpha(p_a - a_a);
draw_text_ext_transformed(X, Y, T, 38, 99999, S, S, 0);
draw_set_alpha(p_a);
