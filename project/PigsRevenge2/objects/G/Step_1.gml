W = window_get_width();
H = window_get_height();
CW = W / 2;
CH = H / 2;
W1 = W * 0.333334;
W2 = W * 0.666667;
H1 = H * 0.333334;
H2 = H * 0.666667;
if (W > H)
{
    A = clamp(H / 574, 0.4, 1);
}
else
{
    A = clamp(W / 1024, 0.4, 1);
}
if (_Sin < 1)
{
    _Sin = lerp(_Sin, 1, 0.25);
}
if (_Sout < 1)
{
    _Sout = lerp(_Sout, 0, 0.25);
}
_S = _Sin * _Sout;
if (_Sout < 0.4)
{
    TReady = 1;
}
camera_set_view_angle(view_camera[0], camera_get_view_angle(view_camera[0]) / 2);
camera_set_view_angle(view_camera[0], clamp(camera_get_view_angle(view_camera[0]), -4, 4));
display_set_gui_size(W, H);
camera_set_view_size(view_camera[0], W * (1.9 - A), camera_get_view_height(view_camera[0]));
view_wport[0] = W * (1.9 - A);
camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]), H * (1.9 - A));
view_hport[0] = H * (1.9 - A);
view_visible[0] = true;
total_time += (1 * (delta_time / 1000000));
if (keyboard_check_pressed(ord("R")))
{
    game_restart();
}
switch (keyboard_key)
{
    case ord("1"):
        current_weapon = weapon_slot[0];
        with (G.selected_slot == boom)
        {
            break;
        }
    case ord("2"):
        current_weapon = weapon_slot[1];
        with (G.selected_slot == enemy)
        {
            break;
        }
    case ord("3"):
        current_weapon = weapon_slot[2];
        with (G.selected_slot == G)
        {
            break;
        }
    case ord("4"):
        current_weapon = weapon_slot[3];
        with (G.selected_slot == o_part_footstep)
        {
            break;
        }
    case ord("J"):
        is_win = 1;
        break;
    case ord("L"):
        NextMenu(10);
        break;
    case ord("K"):
        NextMenu(11);
        break;
    case ord("N"):
        NextMenu(999);
        break;
    case vk_f5:
        control_type_walk = 0;
        break;
    case vk_f6:
        control_type_walk = 1;
        break;
    case vk_f7:
        control_type_walk = 2;
        break;
    case vk_f9:
        control_type_shot = 0;
        break;
    case vk_f10:
        control_type_shot = 1;
        break;
    case vk_f11:
        control_type_shot = 2;
        break;
    case vk_escape:
        game_end();
        break;
    case ord("P"):
        money = 1000000;
        gold = 1000000;
        break;
}
if (keyboard_check_pressed(vk_enter))
{
    GameDestroy();
    NextMenu(12);
    map_type = irandom(8);
    keyboard_clear(vk_enter);
    GameInit();
}
if (keyboard_check_pressed(ord("O")))
{
    for (var i = 0; i < 35; i++)
    {
        weapon_avaible[i] = 1;
    }
}
if (mouse_wheel_down())
{
    weapon_slot[selected_slot]--;
}
if (mouse_wheel_up())
{
    weapon_slot[selected_slot]++;
}
weapon_slot[selected_slot] = clamp(weapon_slot[selected_slot], 0, __c_array_height_2d(WPN) - 1);
current_weapon = clamp(current_weapon, 0, __c_array_height_2d(WPN) - 1);
current_weapon = weapon_slot[selected_slot];
if (!G.music)
{
    StopAllMusic();
}
