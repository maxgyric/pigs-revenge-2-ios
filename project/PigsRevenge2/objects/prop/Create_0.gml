__compat_init();
if (distance_to_object(player) < 1)
{
    instance_destroy();
}
alarm[0] = 1;
if (G.map_type == 0)
{
    sprite_index = __S(choose(7, 8, 9, 11, 12, 13, 24));
}
if (G.map_type == 1)
{
    sprite_index = __S(choose(10, 24, 23));
}
if (G.map_type == 2)
{
    sprite_index = __S(choose(1, 10, 14, 15, 27));
}
if (G.map_type == 3)
{
    sprite_index = __S(choose(25, 24, 23));
}
if (G.map_type == 5)
{
    sprite_index = __S(choose(26, 24, 23));
}
if (G.map_type == 6)
{
    sprite_index = __S(choose(17, 18, 21));
}
if (G.map_type == 7)
{
    sprite_index = __S(choose(16, 17, 21));
}
if (G.map_type == 8)
{
    sprite_index = __S(choose(5, 6, 19));
}
if (__SR(sprite_index) == 5 || __SR(sprite_index) == 6 || __SR(sprite_index) == 10 || __SR(sprite_index) == 11 || __SR(sprite_index) == 12 || __SR(sprite_index) == 13 || __SR(sprite_index) == 14 || __SR(sprite_index) == 15 || __SR(sprite_index) == 16 || __SR(sprite_index) == 18 || __SR(sprite_index) == 21 || __SR(sprite_index) == 23 || __SR(sprite_index) == 25 || __SR(sprite_index) == 26 || __SR(sprite_index) == 27 || __SR(sprite_index) == 17)
{
    solid = 1;
}
depth = -y;
image_speed = 0;
image_index = irandom(sprite_get_number(__S(__SR(sprite_index))));
see = 0;
