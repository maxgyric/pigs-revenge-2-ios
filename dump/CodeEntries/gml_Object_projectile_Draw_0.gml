if (type == 0 || type == 1)
{
    if (!F_dest)
    {
        draw_sprite_ext(sp_fbloom, 0, x, y, 1.5, 0.5, direction, c_red, clamp(1 - (F / 20), 0, 0.5) / 3);
        if (!is_rocket)
        {
            var prev_a = draw_get_alpha();
            var prev_c = draw_get_colour();
            draw_set_alpha((1 - (F / 30)) / 8);
            draw_set_color(c_gray);
            if (type == 1)
            {
                draw_set_color(c_red);
            }
            draw_line_width(xstart, ystart, x, y, 4);
            draw_set_alpha(prev_a);
            draw_set_color(prev_c);
        }
        var sp = 122;
        if (type == 1)
        {
            sp = 119;
        }
        if (explosive && type != 1)
        {
            sp = 123;
        }
        if (is_rocket)
        {
            sp = 131;
        }
        draw_sprite_ext(sp, 0, x, y, 0.8 + (0.5 * (sp == 131)), 0.3 + (0.5 * (sp == 131)), direction, c_white, 1);
        if (F < 10)
        {
            draw_sprite_ext(sp_partbang, (F / 2) + 1, xstart, ystart, 0.2, 0.2, rand_rot, c_white, 1);
        }
    }
    else
    {
        var sp = 128;
        if (state == 1)
        {
            sp = 82;
        }
        draw_sprite_ext(sp, F_dest / 2, x, y, 0.25, 0.25, rand_rot, c_white, 1);
        if ((F_dest / 2) > (sprite_get_number(sp_partbang) - 1))
        {
            instance_destroy();
        }
    }
}
if (type == 2 || type == 3 || type == 4)
{
    if (!F_dest)
    {
        var sp = 126;
        if (type == 2)
        {
            sp = 127;
        }
        if (type == 4)
        {
            sp = 125;
        }
        draw_sprite_ext(sp, 0, xprevious, yprevious, 2, 0.75, direction, c_white, 0.5);
        if (F < 10)
        {
            draw_sprite_ext(sp_partbang, (F / 2) + 1, xstart, ystart, 0.2, 0.2, rand_rot, c_white, 1);
        }
    }
}
if (type == 6)
{
    if (!F_dest)
    {
        z += zspeed;
        zspeed += zgravity;
        if (z > 0)
        {
            zspeed = -zspeed * 0.8;
            z -= 2;
            if (!audio_is_playing(SnGrHit))
            {
                PS(6);
            }
        }
        if (z < 2 && abs(zspeed) < 1)
        {
            hspeed *= 0.8;
            vspeed *= 0.8;
        }
        draw_sprite_ext(sp_fbloom, 0, x, y + 16, 0.5, 0.25, 0, c_black, 1);
        draw_sprite_ext(sp_grenade, 0, x, y + 16 + z, 0.5, 0.5, rand_rot + (x * 2), c_white, 1);
    }
}
if (type == 7)
{
    if (!F_dest)
    {
        var len = array_height_2d(shots);
        for (var i = 0; i < len; i++)
        {
            if (shots[i, 4] == 1)
            {
                continue;
            }
            shots[i, 0] += lengthdir_x(shots[i, 2], shots[i, 3]);
            shots[i, 1] += lengthdir_y(shots[i, 2], shots[i, 3]);
            var prev_a = draw_get_alpha();
            var prev_c = draw_get_colour();
            draw_set_alpha((1 - (F / 30)) / 16);
            draw_set_color(c_gray);
            draw_line_width(xstart, ystart, shots[i, 0], shots[i, 1], 4);
            draw_set_alpha(prev_a);
            draw_set_color(prev_c);
            var sp = 120;
            if (explosive)
            {
                sp = 121;
            }
            draw_sprite_ext(sp, 0, shots[i, 0], shots[i, 1], 0.6, 0.6, direction, c_white, 1);
            if (F < 10)
            {
                draw_sprite_ext(sp_partbang, (F / 2) + 1, xstart, ystart, 0.2, 0.2, rand_rot, c_white, 1);
            }
        }
    }
}
if (type == 8)
{
    var a_a = 1 - (F / 60);
    var sc = (F / 60) + 0.5;
    a_a = clamp(a_a, 0, 1);
    draw_sprite_ext(sp_fbloom, 0, x, y, 6 * sc, 6 * sc, rand_rot + (x / 5), c_orange, a_a);
    var hsp = hspeed * 4;
    var vsp = vspeed * 4;
    var sc2 = 0.8 * sc;
    var sc3 = 1.3 * sc;
    var sc4 = 1 * sc;
    var dir = direction + (rand_rot + (x / 5));
    draw_sprite_ext(sp_partfire, (F / 2) + 5, x - hsp, y - vsp, sc2, sc2, dir, c_white, a_a);
    draw_sprite_ext(sp_partfire, F / 2, x, y, sc4, sc4, dir, c_white, a_a);
    draw_sprite_ext(sp_partfire, (F / 2) + 10, x + hsp, y + vsp, sc3, sc3, dir, c_white, a_a);
}
