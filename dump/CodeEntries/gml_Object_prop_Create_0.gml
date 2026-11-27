if (distance_to_object(player) < 1)
{
    instance_destroy();
}
alarm[0] = 1;
if (G.map_type == 0)
{
    sprite_index = choose(sp_green_bush0, sp_green_bush1, sp_green_bush2, sp_tree0, sp_tree1, sp_tree2, sp_shrooms);
}
if (G.map_type == 1)
{
    sprite_index = choose(sp_dead_wood, sp_shrooms, sp_crystalls);
}
if (G.map_type == 2)
{
    sprite_index = choose(sp_sandstones0, sp_dead_wood, sp_tree3, sp_tree4, sp_colonna2);
}
if (G.map_type == 3)
{
    sprite_index = choose(sp_skala, sp_shrooms, sp_crystalls);
}
if (G.map_type == 5)
{
    sprite_index = choose(sp_colonna, sp_shrooms, sp_crystalls);
}
if (G.map_type == 6)
{
    sprite_index = choose(sp_barrels, sp_wheels0, sp_toilet);
}
if (G.map_type == 7)
{
    sprite_index = choose(sp_porp_rockets, sp_barrels, sp_toilet);
}
if (G.map_type == 8)
{
    sprite_index = choose(sp_winter_wood, sp_winter_bush, sp_wintergrass);
}
if (sprite_index == sp_winter_wood || sprite_index == sp_winter_bush || sprite_index == sp_dead_wood || sprite_index == sp_tree0 || sprite_index == sp_tree1 || sprite_index == sp_tree2 || sprite_index == sp_tree3 || sprite_index == sp_tree4 || sprite_index == sp_porp_rockets || sprite_index == sp_wheels0 || sprite_index == sp_toilet || sprite_index == sp_crystalls || sprite_index == sp_skala || sprite_index == sp_colonna || sprite_index == sp_colonna2 || sprite_index == sp_barrels)
{
    solid = 1;
}
depth = -y;
image_speed = 0;
image_index = irandom(sprite_get_number(sprite_index));
see = 0;
