function DrawWeapon() {
    var S = argument0;
    var X = argument1;
    var Y = argument2 - (10 * S);
    var look_dir = argument3;
    var xscale = argument4;
    var WPS = 0.7 * S * xscale;
    var anim_type = G.WPN[G.current_weapon, 9];
    var muzzle_dis = G.WPN[G.current_weapon, 12];
    var muzzle_rot = G.WPN[G.current_weapon, 11];
    var m_x = X + lengthdir_x((muzzle_dis * S) + WPS, (muzzle_rot * xscale) + look_dir);
    var m_y = Y + lengthdir_y((muzzle_dis * S) + WPS, (muzzle_rot * xscale) + look_dir);
    var wp_sprite = G.WPN[G.current_weapon, 8];
    if (anim_type == 0)
    {
        var add_rot;
        switch (G.WPN[G.current_weapon, 0])
        {
            case 1:
                add_rot = cos((last_shot_time / 2) + 1.0471975511965976) * 120 * (1 - clamp(last_shot_time / 15, 0, 1));
                break;
            case 2:
                add_rot = cos((last_shot_time / 2) + 0.7853981633974483) * 120 * (1 - clamp(last_shot_time / 15, 0, 1));
                break;
            case 3:
            case 7:
                add_rot = cos((last_shot_time / 2) + 0.7853981633974483) * 120 * (1 - clamp(last_shot_time / 15, 0, 1));
                break;
            default:
                add_rot = cos(last_shot_time / 2) * 80 * (1 - clamp(last_shot_time / 15, 0, 1));
                break;
        }
        add_rot *= xscale;
        var hand_lx = lengthdir_x(-40 * S, look_dir + (150 * xscale) + add_rot);
        var hand_ly = lengthdir_y(-40 * S, look_dir + (150 * xscale) + add_rot);
        var hand_lx2 = lengthdir_x(-40 * S, look_dir + (180 * xscale) + add_rot);
        var hand_ly2 = lengthdir_y(-40 * S, look_dir + (180 * xscale) + add_rot);
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, wp_sprite, 0, (S * xscale) + WPS, xscale + WPS, look_dir + (75 * xscale) + add_rot);
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, 68, 0, S * xscale, xscale, look_dir + add_rot);
        DS(X + hand_lx, (Y - (50 * S)) + hand_ly, 68, 0, S * xscale, xscale, look_dir + add_rot);
    }
    else if (anim_type == 1)
    {
        var hand_lx = lengthdir_x(20 * S, look_dir);
        var hand_ly = lengthdir_y(20 * S, look_dir);
        var hand_lx2 = lengthdir_x(-20 * S, look_dir + (90 * xscale));
        var hand_ly2 = lengthdir_y(-20 * S, look_dir + (90 * xscale));
        var wp_rot_add = clamp(wait_next_shot * 4, 0, 35) * xscale;
        DS(X + hand_lx, (Y - (50 * S)) + hand_ly, wp_sprite, 0, (S * xscale) + WPS, xscale + WPS, look_dir + (wp_rot_add * shot_second));
        DS(X + hand_lx, (Y - (50 * S)) + hand_ly, 68, 0, S * xscale, xscale, look_dir + (wp_rot_add * shot_second));
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, wp_sprite, 0, (S * xscale) + WPS, xscale + WPS, look_dir + (wp_rot_add * !shot_second));
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, 68, 0, S * xscale, xscale, look_dir + (wp_rot_add * !shot_second));
    }
    else if (anim_type == 2)
    {
        var wp_rot_add = clamp(wait_next_shot * 4, 0, 10) * xscale;
        var wp_offset = clamp(wp_rot_add, -25, 25) * S * -xscale;
        var hand_lx = lengthdir_x((40 * S) + wp_offset, look_dir + wp_rot_add);
        var hand_ly = lengthdir_y((40 * S) + wp_offset, look_dir + wp_rot_add);
        var hand_lx2 = lengthdir_x((-40 * S) + wp_offset, look_dir + wp_rot_add);
        var hand_ly2 = lengthdir_y((-40 * S) + wp_offset, look_dir + wp_rot_add);
        var fr = 0;
        if (G.WPN[G.current_weapon, 0] == 31 && (reloading_time > 0 || wait_next_shot > 0))
        {
            fr = 1;
        }
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, wp_sprite, fr, (S * xscale) + WPS, xscale + WPS, look_dir + wp_rot_add);
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, 68, 0, S * xscale, xscale, look_dir + wp_rot_add);
        DS(X + hand_lx, (Y - (50 * S)) + hand_ly, 69, 0, S * xscale, xscale, look_dir + wp_rot_add);
    }
    else if (anim_type == 3)
    {
        var hand_lx2 = lengthdir_x(-40 * S, look_dir);
        var hand_ly2 = lengthdir_y(-40 * S, look_dir);
        var wp_rot_add = clamp(wait_next_shot * 4, 0, 35) * xscale;
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, wp_sprite, 0, (S * xscale) + WPS, xscale + WPS, look_dir + wp_rot_add);
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, 68, 0, S * xscale, xscale, look_dir + wp_rot_add);
    }
    else if (anim_type == 4)
    {
        var add_rot = cos((last_shot_time / 2) + 1.0471975511965976) * 120 * (1 - clamp(last_shot_time / 15, 0, 1));
        add_rot *= xscale;
        var hand_lx = lengthdir_x(-20 * S, look_dir);
        var hand_ly = lengthdir_y(-20 * S, look_dir);
        var hand_lx2 = lengthdir_x(-40 * S, look_dir + (180 * xscale));
        var hand_ly2 = lengthdir_y(-40 * S, look_dir + (180 * xscale));
        DS(X + hand_lx2, (Y - (50 * S)) + hand_ly2, wp_sprite, 0, (S * xscale) + WPS, xscale + WPS, look_dir + (45 * xscale) + add_rot);
        DS(X + hand_lx, (Y - (50 * S)) + hand_ly, 68, 0, S * xscale, xscale, look_dir);
    }
    if (event_shot)
    {
        __c_instance_create(m_x, m_y - (50 * S), projectile);
        event_shot = 0;
    }
}
