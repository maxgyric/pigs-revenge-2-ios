image_alpha = 1 - see;
if (instance_exists(player))
{
    myp = instance_nearest(x, y, player);
    if (myp.depth > depth && myp.y > (y - sprite_get_height(__S(__SR(sprite_index)))) && myp.x > (x - (sprite_get_width(__S(__SR(sprite_index))) / 2)) && myp.x < (x + (sprite_get_width(__S(__SR(sprite_index))) / 2)))
    {
        see += 0.1;
    }
}
see -= 0.05;
see = clamp(see, 0, 0.5);
