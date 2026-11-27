if (game_active)
{
    instance_activate_all();
    with (player)
    {
        instance_destroy();
    }
    with (projectile)
    {
        instance_destroy();
    }
    with (enemy)
    {
        instance_destroy();
    }
    with (part_bullethit)
    {
        instance_destroy();
    }
    with (part_texthit)
    {
        instance_destroy();
    }
    with (part_deadplayer)
    {
        instance_destroy();
    }
    with (part_blood0)
    {
        instance_destroy();
    }
    with (prop)
    {
        instance_destroy();
    }
    with (part_coins)
    {
        instance_destroy();
    }
    with (o_powerup)
    {
        instance_destroy();
    }
    map_props = 0;
    game_active = 0;
    is_win = 0;
    weath_t = 0;
    for (var i = 0; i < 5; i++)
    {
        G.pwrup[i] = 0;
    }
    if (keyboard_check(vk_enter))
    {
        with (G)
        {
            battle_kills = 0;
            battle_time = 0;
            battle_money = 0;
            check_ach = 1;
            got_medal = 0;
            battle_damage_get = 0;
        }
    }
    quest_id = 0;
    quest_v = 0;
    quest_f = 0;
    quest_data = 0;
}
