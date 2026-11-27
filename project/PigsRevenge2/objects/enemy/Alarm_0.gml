if (instance_exists(player))
{
    my_target = instance_nearest(x, y, player);
}
else
{
    alarm[0] = 10;
}
