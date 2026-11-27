if (!game_active)
{
    var shit = play_level;
    while (shit > 9)
    {
        shit -= 10;
    }
    var ass = 0;
    var ccn = 0;
    var stg = 0;
    while (ass < play_level)
    {
        ass++;
        ccn++;
        if (ccn > 9)
        {
            ccn = 0;
            stg++;
        }
    }
    stg = floor(stg);
    while (stg > 8)
    {
        stg -= 9;
    }
    map_type = stg;
    switch (stg)
    {
        case 0:
            enemy_sprite_0 = 139;
            enemy_sprite_0a = 140;
            enemy_sprite_1 = 141;
            enemy_sprite_1a = 142;
            enemy_sprite_2 = 143;
            enemy_sprite_2a = 144;
            enemy_sprite_3 = 157;
            enemy_sprite_3a = 158;
            break;
        case 1:
            enemy_sprite_0 = 145;
            enemy_sprite_0a = 146;
            enemy_sprite_1 = 147;
            enemy_sprite_1a = 148;
            enemy_sprite_2 = 149;
            enemy_sprite_2a = 150;
            enemy_sprite_3 = 153;
            enemy_sprite_3a = 154;
            break;
        case 2:
            enemy_sprite_0 = 151;
            enemy_sprite_0a = 152;
            enemy_sprite_1 = 155;
            enemy_sprite_1a = 156;
            enemy_sprite_2 = 149;
            enemy_sprite_2a = 150;
            enemy_sprite_3 = 171;
            enemy_sprite_3a = 172;
            break;
        case 3:
            enemy_sprite_0 = 167;
            enemy_sprite_0a = 168;
            enemy_sprite_1 = 169;
            enemy_sprite_1a = 170;
            enemy_sprite_2 = 171;
            enemy_sprite_2a = 172;
            enemy_sprite_3 = 173;
            enemy_sprite_3a = 174;
            break;
        case 4:
            enemy_sprite_0 = 159;
            enemy_sprite_0a = 160;
            enemy_sprite_1 = 161;
            enemy_sprite_1a = 162;
            enemy_sprite_2 = 163;
            enemy_sprite_2a = 164;
            enemy_sprite_3 = 165;
            enemy_sprite_3a = 166;
            break;
        case 5:
            enemy_sprite_0 = 167;
            enemy_sprite_0a = 168;
            enemy_sprite_1 = 169;
            enemy_sprite_1a = 170;
            enemy_sprite_2 = 171;
            enemy_sprite_2a = 172;
            enemy_sprite_3 = 173;
            enemy_sprite_3a = 174;
            break;
        case 6:
            enemy_sprite_0 = 157;
            enemy_sprite_0a = 158;
            enemy_sprite_1 = 153;
            enemy_sprite_1a = 154;
            enemy_sprite_2 = 147;
            enemy_sprite_2a = 148;
            enemy_sprite_3 = 149;
            enemy_sprite_3a = 150;
            break;
        case 7:
            enemy_sprite_0 = 155;
            enemy_sprite_0a = 156;
            enemy_sprite_1 = 149;
            enemy_sprite_1a = 150;
            enemy_sprite_2 = 139;
            enemy_sprite_2a = 140;
            enemy_sprite_3 = 173;
            enemy_sprite_3a = 174;
            break;
        case 8:
            enemy_sprite_0 = 161;
            enemy_sprite_0a = 162;
            enemy_sprite_1 = 151;
            enemy_sprite_1a = 152;
            enemy_sprite_2 = 141;
            enemy_sprite_2a = 142;
            enemy_sprite_3 = 173;
            enemy_sprite_3a = 174;
            break;
    }
    quest_f = -1;
    instance_create(450 + irandom(room_width - 900), 450 + irandom(room_height - 900), player);
    var N = 1;
    if (play_level > 80)
    {
        N++;
    }
    if (play_level > 60)
    {
        N++;
    }
    if (play_level > 40)
    {
        N++;
    }
    if (play_level > 20)
    {
        N++;
    }
    repeat (N)
    {
        instance_create(450 + irandom(room_width - 900), 450 + irandom(room_height - 900), o_powerup);
    }
    if (shit == 9 || shit == 5)
    {
        quest_id = 1;
    }
    else if (shit == 3 || shit == 8)
    {
        quest_id = 2;
    }
    else
    {
        quset_id = 0;
    }
    var count = 15 + ceil(play_level / 3);
    if (count > 60)
    {
        count = 60;
    }
    if (quest_id == 1)
    {
        count *= 1;
        count = ceil(count);
    }
    if (quest_id == 2)
    {
        count *= 1.25;
        count = ceil(count);
    }
    if (quest_id == 2)
    {
        count *= 1.5;
    }
    if (quest_id == 1)
    {
        count /= 3;
    }
    repeat (ceil(count))
    {
        var spawn = choose(0, 1);
        var s_x = -30 + random(room_width + 60);
        var s_y = -30 + random(room_height + 60);
        if (spawn)
        {
            s_x = choose(-30, room_width + 60);
        }
        else
        {
            s_y = choose(-30, room_height + 60);
        }
        instance_create(s_x, s_y, enemy);
    }
    var tex = 0;
    switch (map_type)
    {
        case 2:
            tex = 1;
            break;
        case 1:
            tex = 3;
            break;
        case 3:
            tex = 3;
            break;
        case 5:
            tex = 3;
            break;
        case 7:
            tex = 3;
            break;
        case 6:
            tex = 4;
            break;
        case 8:
            tex = 2;
            break;
    }
    var i_ = 0;
    for (var i = 0; i < (ceil(room_width / 250) + 1); i++)
    {
        for (var ii = 0; ii < (ceil(room_height / 250) + 1); ii++)
        {
            map_props[i_, 0] = (ii * 250) + random(250);
            map_props[i_, 1] = (i * 250) + random(250);
            map_props[i_, 2] = tex;
            map_props[i_, 3] = irandom(sprite_get_number(map_props[i_, 2]));
            if (choose(0, 1))
            {
                map_props[i_, 0] = -999;
            }
            if (G.map_type != 4)
            {
                instance_create((ii * 250) + random(250), (i * 250) + random(250), prop);
            }
            i_++;
        }
    }
    weath_t = choose(0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 3, 4);
    switch (G.map_type)
    {
        case 2:
            weath_t = choose(0, 0, 0, 0, 6);
            break;
        case 3:
            weath_t = 4;
            break;
        case 4:
            weath_t = 0;
            break;
        case 7:
            weath_t = choose(0, 0, 0, 0, 0, 4);
            break;
        case 8:
            weath_t = choose(0, 0, 5);
            break;
    }
    weath_time = irandom(24);
    if (shit < 5 && play_level < 40)
    {
        weath_t = 0;
        weath_time = 12;
    }
    is_win = 0;
    game_active = 1;
}
