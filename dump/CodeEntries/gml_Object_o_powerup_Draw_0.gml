if (!picked)
{
    var as = sin(image_index / 4);
    var ss = 0.8 + (sin(image_index / 8) / 3);
    var sp = 218;
    draw_sprite_ext(sp_powerup0, 0, x, y, ss, ss, 0, c_white, 1);
    draw_sprite_ext(sp_powerup0, 0, x, y, -ss, ss, 0, c_white, 1);
    switch (type)
    {
        case 1:
            sp = 219;
            break;
        case 2:
            sp = 220;
            break;
        case 3:
            sp = 221;
            break;
        case 4:
            sp = 51;
            break;
    }
    var sc = 0.8 - (0.2 * (type == 4));
    draw_sprite_ext(sp, 0, x, (y - 35) + (as * 5), sc, sc, 0, c_white, 1);
}
