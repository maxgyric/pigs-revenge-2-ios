if (instance_exists(player))
{
    myp = instance_nearest(x, y, player);
    if (point_distance(myp.x, myp.y, x, y) < 48 && picked == 0)
    {
        picked = 1;
        alarm[0] = 300;
        PS(98);
        G.pwrup[type] = 300;
        if (type == 3)
        {
            G.pwrup[type] = 150;
        }
        var myt = instance_create(x, y - 70, part_texthit);
        myt.powerup_hint = type;
        myt.visible = false;
        myt.alarm[0] = 1;
    }
}
