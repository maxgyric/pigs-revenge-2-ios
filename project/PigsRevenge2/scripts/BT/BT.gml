function BT() {
    var X = argument0;
    var Y = argument1;
    var S = clamp(argument5 * G.A, 0.2, 1);
    var press = 0;
    var action = 0;
    var p_a = draw_get_alpha();
    var a_a = 0;
    if (_S < 0.5)
    {
        a_a = 1 - (_S / 2);
    }
    var XS = (sprite_get_width(__S(argument2)) / 2) * S * _S;
    var YS = (sprite_get_height(__S(argument2)) / 2) * S * _S;
    if (window_mouse_get_x() > (X - XS) && window_mouse_get_x() < (X + XS) && window_mouse_get_y() > (Y - YS) && window_mouse_get_y() < (Y + YS) && _S > 0.5 && _Sout == 1 && AllowPress && !cutscene_show && trans_type == 0)
    {
        press = 4;
        if (mouse_check_button(mb_any))
        {
            press = 2;
        }
        if (mouse_check_button_pressed(mb_any))
        {
            press = 1;
        }
        if (mouse_check_button_released(mb_any))
        {
            press = 3;
        }
        if (press == 3)
        {
            check_ach = 1;
            PS(1);
            action = 1;
        }
    }
    switch (press)
    {
        case 1:
            XS *= 0.98;
            YS *= 0.98;
            break;
        case 2:
            XS *= 0.96;
            YS *= 0.96;
            break;
        case 3:
            XS *= 0.98;
            YS *= 0.98;
            break;
        case 4:
            XS *= 1.02;
            YS *= 1.02;
            break;
    }
    draw_sprite_pos(__S(argument2), argument3, X - XS, Y - YS, X + XS, Y - YS, X + XS, Y + YS, X - XS, Y + YS, draw_get_alpha() - a_a);
    DT(X, Y + YS + (8 * A), argument4, 0.65);
    draw_set_alpha(p_a);
    return action;
}
