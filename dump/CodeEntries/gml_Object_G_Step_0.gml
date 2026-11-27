if (control_type_shot == 2)
{
    if (instance_exists(enemy) && instance_exists(player))
    {
        p = instance_nearest(x, y, player);
        e = instance_nearest(p.x, p.y, enemy);
        dir_shot = point_direction(p.x, p.y, e.x, e.y);
        if ((G.WPN[G.current_weapon, 9] == 1 || G.WPN[G.current_weapon, 9] == 2 || G.WPN[G.current_weapon, 9] == 3) && G.WPN[G.current_weapon, 0] != 4)
        {
            ready_shot = 1;
        }
        else if (point_distance(p.x, p.y, e.x, e.y) < 150)
        {
            ready_shot = 1;
        }
        else
        {
            ready_shot = 0;
        }
        if (point_distance(p.x, p.y, e.x, e.y) > CW)
        {
            ready_shot = 0;
        }
    }
    else
    {
        ready_shot = 0;
    }
}
if (sounds)
{
    var play_fire_loop = 0;
    var play_chain_loop = 0;
    if (instance_exists(projectile))
    {
        var count = instance_number(projectile);
        for (var i = 0; i < count; i++)
        {
            var bb = instance_find(projectile, i).type;
            if (bb == 8)
            {
                play_fire_loop = 1;
                i = count + 1;
            }
            if (bb == 9)
            {
                play_chain_loop = 1;
                i = count + 1;
            }
        }
    }
    if (play_fire_loop && !audio_is_playing(SnWpFireLoop))
    {
        audio_play_sound(SnWpFireLoop, 1, false);
        if (!start_sound_flame)
        {
            PS(13);
            start_sound_flame = 1;
        }
    }
    if (!play_fire_loop)
    {
        start_sound_flame = 0;
        audio_stop_sound(SnWpFireLoop);
    }
    if (play_chain_loop && !audio_is_playing(SnWpChainShot))
    {
        audio_play_sound(SnWpChainShot, 1, false);
        if (!start_sound_flame)
        {
            PS(11);
            start_sound_chain = 1;
        }
    }
    if (!play_chain_loop)
    {
        start_sound_chain = 0;
        audio_stop_sound(SnWpChainShot);
    }
}
if (!sounds)
{
    if (audio_is_playing(SnWpFireStart) || audio_is_playing(SnWpFireLoop) || audio_is_playing(SnWpChainEnd) || audio_is_playing(SnWpChainShot) || audio_is_playing(SnWpChainStart))
    {
        audio_stop_sound(SnWpFireStart);
        audio_stop_sound(SnWpFireLoop);
        audio_stop_sound(SnWpChainEnd);
        audio_stop_sound(SnWpChainShot);
        audio_stop_sound(SnWpChainStart);
    }
}
if (combo > 0)
{
    combo--;
}
else
{
    combo_x = 0;
}
for (var i = 0; i < 4; i++)
{
    var cnt_start = i * 7;
    var cnt_end = cnt_start + 7;
    if (i != 0)
    {
        cnt_end += 7;
        cnt_start += 7;
    }
    else
    {
        cnt_end += 7;
    }
    for (var k = cnt_start; k < cnt_end; k++)
    {
        if (weapon_avaible[k] && weapon_slot[i] == -1)
        {
            weapon_slot[i] = k;
        }
    }
}
if (expa >= expa_next_level)
{
    expa -= expa_next_level;
    level_up_x = 1;
    hero_level++;
    repeat (3)
    {
        PS(93);
    }
    audio_stop_sound(SnGore0);
    audio_stop_sound(SnGore1);
    audio_stop_sound(SnGore2);
    audio_stop_sound(SnGore3);
    expa_next_level *= 1.2;
    expa_next_level = ceil(expa_next_level);
}
if (check_ach)
{
    check_ach = 0;
    for (var i = 0; i < array_length_1d(ach_map); i++)
    {
        if (ach_map[i])
        {
            continue;
        }
        var gotit = 0;
        switch (i)
        {
            case 0:
                if (frags > 99)
                {
                    gotit = 1;
                }
                break;
            case 1:
                if (total_time > 3600)
                {
                    gotit = 1;
                }
                break;
            case 2:
                if (play_level > 99)
                {
                    gotit = 1;
                }
                break;
            case 3:
                if (hero_level > 19)
                {
                    gotit = 1;
                }
                break;
            case 4:
                if (M == 11)
                {
                    gotit = 1;
                }
                break;
            case 5:
                if (play_level > 999)
                {
                    gotit = 1;
                }
                break;
            case 6:
                if (total_time > 36000)
                {
                    gotit = 1;
                }
                break;
            case 7:
                if (frags > 1999)
                {
                    gotit = 1;
                }
                break;
            case 8:
                if (control_type_shot == 2)
                {
                    gotit = 1;
                }
                break;
            case 9:
                if (hero_level > 99)
                {
                    gotit = 1;
                }
                break;
            case 11:
                if (total_time > 360000)
                {
                    gotit = 1;
                }
                break;
            case 12:
                if (gold > 0)
                {
                    gotit = 1;
                }
                break;
            case 13:
                if (hero_level > 499)
                {
                    gotit = 1;
                }
                break;
            case 14:
                if (frags > 499999)
                {
                    gotit = 1;
                }
                break;
            case 19:
                if (frags > 999999)
                {
                    gotit = 1;
                }
                break;
            case 16:
                gotit = 1;
                for (var k = 0; k < array_height_2d(dress_avaible); k++)
                {
                    if (!dress_avaible[k, 0])
                    {
                        gotit = 0;
                    }
                }
                break;
            case 15:
                gotit = 1;
                for (var k = 0; k < array_height_2d(hat_avaible); k++)
                {
                    if (!hat_avaible[k, 0])
                    {
                        gotit = 0;
                    }
                }
                break;
            case 17:
                gotit = 1;
                for (var k = 0; k < array_length_1d(dress_avaible); k++)
                {
                    if (!weapon_avaible[k])
                    {
                        gotit = 0;
                    }
                }
                break;
            case 18:
                bought = 0;
                for (var k = 0; k < 35; k++)
                {
                    for (var q = 0; q < 4; q++)
                    {
                        bought += UW_map[k, q];
                    }
                }
                if (bought > 491)
                {
                    gotit = 1;
                }
                break;
        }
        ach_map[i] = gotit;
    }
}
if (quest_id == 0 && play_level == 0 && M == 12)
{
    var FF = quest_v[6];
    if (FF == 30 && quest_v[1] == 0)
    {
        hint_time = 80;
        hint_mess = 154;
        hint_a = 0;
        quest_v[1] = 1;
    }
    if (FF == 160 && quest_v[2] == 0)
    {
        hint_time = 200;
        hint_mess = 153;
        hint_a = 0;
        quest_v[2] = 1;
    }
    if (FF == 350 && quest_v[3] == 0)
    {
        hint_time = 100;
        hint_mess = 156;
        hint_a = 0;
        quest_v[3] = 1;
    }
    if (FF == 500 && quest_v[4] == 0)
    {
        hint_time = 150;
        hint_mess = 155;
        hint_a = 0;
        quest_v[4] = 1;
    }
}
if (quest_id == 0 && play_level == 1 && M == 12)
{
    if (F == 30 && quest_v[1] == 0)
    {
        hint_time = 100;
        hint_mess = 157;
        hint_a = 0;
    }
    if (F == 200)
    {
        hint_time = 100;
        hint_mess = 159;
        hint_a = 0;
    }
    if (F == 340)
    {
        hint_time = 100;
        hint_mess = 160;
        hint_a = 0;
    }
}
if ((quest_id == 1 || quest_id == 2) && play_level < 7 && M == 12)
{
    if (F == 30)
    {
        hint_time = 100;
        hint_mess = 158;
        hint_a = 0;
    }
}
if (quest_id == 0)
{
    var shit_add = play_level * 3;
    if (shit_add > 600)
    {
        shit_add = 600;
    }
    if (quest_f == 0)
    {
        quest_v[0] = 50 + shit_add;
        quest_v[1] = 0;
        quest_v[2] = 0;
        quest_v[3] = 0;
        quest_v[4] = 0;
        quest_v[5] = 0;
        quest_v[6] = 0;
    }
    if (M == 12)
    {
        quest_v[6]++;
    }
    if (quest_v[0] <= 0 && is_win == 0)
    {
        is_win = 1;
        if (battle_time < 80)
        {
            got_medal = 2;
        }
        else if (battle_time < 120)
        {
            got_medal = 1;
        }
        else
        {
            battle_time = 0;
        }
    }
    quest_f++;
}
if (quest_id == 1)
{
    if (quest_f == 1)
    {
        quest_v[0] = instance_create(room_width / 2, room_height / 2, enemy);
        var boss = quest_v[0];
        with (boss)
        {
            sprite[0] = G.enemy_sprite_3;
            sprite[1] = G.enemy_sprite_3a;
            sw = (sprite_get_width(sprite[0]) / 2) * scale;
            sh = (sprite_get_height(sprite[0]) / 2) * scale;
            image_speed = sprite_get_number(sprite[0]) / 10;
        }
        boss.hp_start *= 60;
        boss.hp = boss.hp_start;
        boss.prev_hp = boss.hp;
        boss.reward *= 5;
        boss.scale *= 1.8;
        boss.color = make_color_rgb(255, 50, 50);
        boss.imboss = 1;
        boss.sw *= 1.5;
        boss.sh *= 1.5;
    }
    if (quest_f > 1)
    {
        if (quest_v[0] == -1 && is_win == 0)
        {
            is_win = 1;
            switch (battle_damage_get)
            {
                case 0:
                    got_medal = 2;
                    break;
                case 1:
                    got_medal = 1;
                    break;
                default:
                    got_medal = 0;
                    break;
            }
        }
    }
    quest_f++;
}
if (quest_id == 2)
{
    var shit_add = ceil(play_level / 5);
    if (shit_add > 45)
    {
        shit_add = 45;
    }
    if (quest_f == 0)
    {
        quest_v[0] = 40 + shit_add;
    }
    if (battle_time > quest_v[0] && is_win == 0)
    {
        is_win = 1;
        switch (battle_damage_get)
        {
            case 0:
                got_medal = 2;
                break;
            case 1:
                got_medal = 1;
                break;
            default:
                got_medal = 0;
                break;
        }
    }
    quest_f++;
}
if (trans_type != 0)
{
    if (trans_step == 0)
    {
        switch (trans_type)
        {
            case 1:
                iap_acquire("add.gold.10", "");
                break;
            case 2:
                iap_acquire("add.gold.3", "");
                break;
            case 3:
                iap_acquire("add.gold.1", "");
                break;
        }
        trans_step = 1;
    }
    if (trans_step == 99)
    {
        trans_step = 0;
        trans_type = 0;
    }
}
aver_fps = lerp(aver_fps, fps, 0.1);
if (M == 12)
{
    for (var i = 0; i < 5; i++)
    {
        if (pwrup[i] > 0)
        {
            pwrup[i]--;
        }
    }
}
if (M != 0)
{
    var MM = 97;
    if (!audio_is_playing(MM) && !audio_is_paused(MM))
    {
        audio_play_sound(MM, 1, true);
    }
    if (((M == 12 || M == 13) || !G.music) && audio_is_playing(MM))
    {
        audio_pause_sound(MM);
    }
    else
    {
        audio_resume_sound(MM);
    }
}
if (adm_money)
{
    if (money < 999999)
    {
        money = 999999;
    }
    if (gold < 999999)
    {
        gold = 999999;
    }
}
if (adm_god)
{
    with (player)
    {
        if (hp < 3)
        {
            hp = 3;
        }
    }
}
if (adm_ammo)
{
    with (player)
    {
        if (ammo_in_slot[G.selected_slot] < G.WPN[G.current_weapon, 5])
        {
            ammo_in_slot[G.selected_slot] = G.WPN[G.current_weapon, 5];
        }
        reloading_time = -1;
    }
}
if (adm_onehit)
{
    with (enemy)
    {
        if (hp < hp_start)
        {
            hp = -1;
        }
    }
}
if (adm_freeze && M == 12)
{
    if (pwrup[3] < 30)
    {
        pwrup[3] = 30;
    }
}
if (adm_msg_t > 0)
{
    adm_msg_t -= 1;
}
if (adm_reset > 0)
{
    adm_reset -= 1;
}
