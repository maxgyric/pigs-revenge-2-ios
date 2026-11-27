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
        audio_stop_sound(my_voice);
        flame_damage = myproj.damage;
        flame = 180;
    }
    if ((myproj.type == 5 || myproj.type == 9) && point_distance(x, y, myproj.x, myproj.y) < (50 + sw) && last_proj != myproj)
    {
        knock_power += myproj.myknock;
        knock_rot = myproj.direction;
        hp -= myproj.damage;
        last_proj = myproj;
        var mypart = instance_create(x + random_range(-sw, sw), y + random_range(-sh, -sh * 2), part_bullethit);
        if (myproj.type == 9)
        {
            mypart.sound = 64;
            mypart.sprite_index = sp_part_hitknife;
            mypart.image_speed = 1;
        }
        else
        {
            mypart.sound = 59;
            mypart.sprite_index = sp_part_hitknife;
            switch (myproj.type_created)
            {
                case 0:
                    mypart.sound = 61;
                    mypart.sprite_index = sp_part_hit;
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
                    mypart.sprite_index = sp_part_hitlaser;
                    mypart.image_blend = c_red;
                    break;
                case 6:
                    mypart.sound = 61;
                    mypart.sprite_index = sp_part_hit;
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
    view_angle[0] = random_range(-2, 2);
    PS(choose(91, 90, 89, 88));
}
if (prev_hp != hp && prev_hp > hp && flame <= 0 && instance_number(part_texthit) < 10)
{
    var mys = instance_create((x - sw) + random(sw * 2), y - (sh * 3), part_texthit);
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
    if (!audio_is_playing(SnZombieHit) && !audio_is_playing(SnZombieHit2) && !audio_is_playing(SnZombieHit3) && !audio_is_playing(SnZombieHit4) && !audio_is_playing(SnZombieHit5) && !audio_is_playing(SnZombieHit6) && !audio_is_playing(SnZombieHit7) && !audio_is_playing(SnZombieHit8) && !audio_is_playing(SnZombieHit9))
    {
        PS(choose(86, 87, 79, 80, 81, 82, 83, 84, 85));
    }
    if (!G.is_win)
    {
        var spawn = choose(0, 1);
        var s_x = (view_xview[0] - 30) + random(view_wview[0] + 60);
        var s_y = (view_yview[0] - 30) + random(view_hview[0] + 60);
        if (spawn)
        {
            s_x = choose(view_xview[0] - 30, view_xview[0] + view_wview[0] + 30);
        }
        else
        {
            s_y = choose(view_yview[0] - 30, view_yview[0] + view_hview[0] + 30);
        }
        instance_create(s_x, s_y, enemy);
    }
    var mypart = instance_create(x, y - sh, part_blood0);
    mypart.image_xscale = scale * 2;
    mypart.image_yscale = mypart.image_xscale;
    G.check_ach = 1;
    instance_create(x, y, part_coins);
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
    if (!audio_is_playing(my_voice))
    {
        if (!audio_is_playing(SnZombie0) && !audio_is_playing(SnZombie1) && !audio_is_playing(SnZombie2) && !audio_is_playing(SnZombie3))
        {
            PS_voc(choose(77, 65, 66, 67));
        }
        if (!audio_is_playing(SnZombie4) && !audio_is_playing(SnZombie5) && !audio_is_playing(SnZombie6) && !audio_is_playing(SnZombie7))
        {
            PS_voc(choose(68, 69, 70, 71));
        }
        if (!audio_is_playing(SnZombie8) && !audio_is_playing(SnZombie9) && !audio_is_playing(SnZombie10) && !audio_is_playing(SnZombie11) && !audio_is_playing(SnZombie12))
        {
            PS_voc(choose(72, 73, 74, 76));
        }
    }
}
else
{
    graphics_walk = 0;
}
if (x < view_xview[0])
{
    x += 5;
}
if (x > (view_xview[0] + view_wview[0]))
{
    x -= 5;
}
if (y < view_yview[0])
{
    y += 5;
}
if (y > (view_yview[0] + view_hview[0]))
{
    y -= 5;
}
