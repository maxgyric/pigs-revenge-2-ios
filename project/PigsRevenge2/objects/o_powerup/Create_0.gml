__compat_init();
type = choose(0, 1, 2, 3, 4);
if (instance_exists(player))
{
    myp = instance_nearest(x, y, player);
    while (point_distance(myp.x, myp.y, x, y) < 48)
    {
        x = 450 + irandom(room_width - 900);
    }
    y = 450 + irandom(room_height - 900);
}
picked = 0;
depth = -y + 16;
