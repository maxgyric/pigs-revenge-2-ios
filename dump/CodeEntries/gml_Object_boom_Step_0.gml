count = instance_number(enemy);
if (image_index < 2)
{
    for (var i = 0; i < count; i++)
    {
        my = instance_find(enemy, i);
        if (point_distance(x, y, my.x, my.y) < (104 * scale))
        {
            my.hp -= damage;
        }
    }
}
