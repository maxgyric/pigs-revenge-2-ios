var target_valid = my_target != -1;
F++;
depth = -y;
if (!target_valid)
{
    alarm[0] = 10;
    my_target = -1;
}
else
{
    if (point_distance(x, y, my_target.x, my_target.y) > 5)
    {
        look_dir = point_direction(x, y, my_target.x, my_target.y);
    }
    if (look_dir < 90 || look_dir > 270)
    {
        xscale = 1;
    }
    else
    {
        xscale = -1;
    }
    goback = look_dir < 180;
}
if (flame > 0)
{
    flame--;
    if (flame_start < 0.5)
    {
        flame_start = 0.5;
    }
    if (flame_start < 1)
    {
        flame_start += 0.1;
    }
    hp -= (flame_damage / 10);
}
else
{
    flame_start = 0;
    played_sound_panic = 0;
}
if (instance_exists(projectile))
{
    var myproj = instance_nearest(x, y, projectile);
    if (myproj.type == 8 && point_distance(x, y, myproj.x, myproj.y) < (50 + sw))
    {
        if (!played_sound_panic)
        {
            played_sound_panic = 1;
        }
        audio_stop_sound(__A(my_voice));
        flame_damage = myproj.damage;
        flame = 180;
    }
    if ((myproj.type == 5 || myproj.type == 9) && point_distance(x, y, myproj.x, myproj.y) < (50 + sw) && last_proj != myproj)
    {
        knock_power += myproj.myknock;
        knock_rot = myproj.direction;
        hp -= myproj.damage;
        last_proj = myproj;
        var mypart = __c_instance_create(x + random_range(-sw, sw), y + random_range(-sh, -sh * 2), part_bullethit);
        if (myproj.type == 9)
        {
            mypart.sound = 64;
            mypart.sprite_index = __S(136);
            mypart.image_speed = 1;
        }
        else
        {
            mypart.sound = 59;
            mypart.sprite_index = __S(136);
            switch (myproj.type_created)
            {
                case 0:
                    mypart.sound = 61;
                    mypart.sprite_index = __S(134);
                    break;
                case 1:
                case 2:
                    mypart.image_speed = 1;
                    break;
                case 3:
                    mypart.sound = 59;
                    mypart.image_speed = 1;
                    break;
                case 5:
                    mypart.sound = 60;
                    mypart.sprite_index = __S(137);
                    mypart.image_blend = c_red;
                    break;
                case 6:
                    mypart.sound = 61;
                    mypart.sprite_index = __S(134);
                    break;
            }
        }
    }
}
else
{
    last_proj = 0;
}
if (knock_power > 0)
{
    knock_power -= 0.5;
    var kn = clamp(knock_power, 0, 4);
    var X = lengthdir_x(kn, knock_rot);
    var Y = lengthdir_y(kn, knock_rot);
    if (place_free(x + X, y))
    {
        x += X;
    }
    if (place_free(x, y + Y))
    {
        y += Y;
    }
}
if (prev_hp != hp && prev_hp > hp && G.pwrup[1] > 0)
{
    hp -= (abs((prev_hp - hp) * 6) - (prev_hp - hp));
    camera_set_view_angle(view_camera[0], random_range(-2, 2));
    PS(choose(91, 90, 89, 88));
}
if (prev_hp != hp && prev_hp > hp && flame <= 0 && instance_number(part_texthit) < 10)
{
    var mys = __c_instance_create((x - sw) + random(sw * 2), y - (sh * 3), part_texthit);
    if (irandom(100) > 99)
    {
        hp -= ((prev_hp - hp) * 2);
        mys.its_crit = 1;
    }
    mys.sc = ceil(prev_hp - hp);
    prev_hp = hp;
}
if (hp < 1)
{
    var add_rew = 2 + ceil(G.play_level / 2) + (10 * G.play_level * imboss);
    if (G.pwrup[4] > 0)
    {
        add_rew *= 3;
    }
    G.combo = 20;
    G.combo_x++;
    G.battle_kills++;
    G.battle_money += add_rew;
    G.money += add_rew;
    G.frags++;
    G.expa += add_rew;
    if (!audio_is_playing(__A(86)) && !audio_is_playing(__A(87)) && !audio_is_playing(__A(79)) && !audio_is_playing(__A(80)) && !audio_is_playing(__A(81)) && !audio_is_playing(__A(82)) && !audio_is_playing(__A(83)) && !audio_is_playing(__A(84)) && !audio_is_playing(__A(85)))
    {
        PS(choose(86, 87, 79, 80, 81, 82, 83, 84, 85));
    }
    if (!G.is_win)
    {
        var spawn = choose(0, 1);
        var s_x = (camera_get_view_x(view_camera[0]) - 30) + random(camera_get_view_width(view_camera[0]) + 60);
        var s_y = (camera_get_view_y(view_camera[0]) - 30) + random(camera_get_view_height(view_camera[0]) + 60);
        if (spawn)
        {
            s_x = choose(camera_get_view_x(view_camera[0]) - 30, camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 30);
        }
        else
        {
            s_y = choose(camera_get_view_y(view_camera[0]) - 30, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 30);
        }
        __c_instance_create(s_x, s_y, enemy);
    }
    var mypart = __c_instance_create(x, y - sh, part_blood0);
    mypart.image_xscale = scale * 2;
    mypart.image_yscale = mypart.image_xscale;
    G.check_ach = 1;
    __c_instance_create(x, y, part_coins);
    event_user(0);
    instance_destroy();
}
if (my_target != -1)
{
    if (!flame)
    {
        if (point_distance(x, y, my_target.x, my_target.y) < 20)
        {
            x += lengthdir_x(3, look_dir + random_range(-5, 5));
            y += lengthdir_y(3, look_dir + random_range(-5, 5));
        }
        else
        {
            x += lengthdir_x(3, look_dir + random_range(-70, 70));
            y += lengthdir_y(3, look_dir + random_range(-70, 70));
        }
    }
    else
    {
        mp_potential_step(x + random_range(-128, 128), y + random_range(-128, 128), 3, 1);
    }
    graphics_walk++;
    if (!audio_is_playing(__A(my_voice)))
    {
        if (!audio_is_playing(__A(77)) && !audio_is_playing(__A(65)) && !audio_is_playing(__A(66)) && !audio_is_playing(__A(67)))
        {
            PS_voc(choose(77, 65, 66, 67));
        }
        if (!audio_is_playing(__A(68)) && !audio_is_playing(__A(69)) && !audio_is_playing(__A(70)) && !audio_is_playing(__A(71)))
        {
            PS_voc(choose(68, 69, 70, 71));
        }
        if (!audio_is_playing(__A(72)) && !audio_is_playing(__A(73)) && !audio_is_playing(__A(74)) && !audio_is_playing(__A(75)) && !audio_is_playing(__A(76)))
        {
            PS_voc(choose(72, 73, 74, 76));
        }
    }
}
else
{
    graphics_walk = 0;
}
if (x < camera_get_view_x(view_camera[0]))
{
    x += 5;
}
if (x > (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])))
{
    x -= 5;
}
if (y < camera_get_view_y(view_camera[0]))
{
    y += 5;
}
if (y > (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])))
{
    y -= 5;
}
