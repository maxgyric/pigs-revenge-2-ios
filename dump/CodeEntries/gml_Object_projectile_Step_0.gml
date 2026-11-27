F++;
depth = -y - 40;
if (state)
{
    speed = 0;
    F_dest++;
}
if (((type == 5 || type == 9) && F > 5) || (type == 8 && F > 60) || (F > 90 && type != 6) || (F > 70 && type == 6))
{
    if (type == 6)
    {
        myboom = instance_create(x, y + z, boom);
        myboom.scale = 1;
    }
    instance_destroy();
}
if (instance_exists(enemy))
{
    if (type != 7)
    {
        var my_enemy = -1;
        for (var i = 0; i < instance_number(enemy); i++)
        {
            var finded = instance_find(enemy, i);
            if (point_in_rectangle(x, y, finded.x - finded.sw, finded.y - (finded.sh * 2), finded.x + finded.sw, finded.y) || point_in_rectangle(x + (hspeed / 2), y + (vspeed / 2), finded.x - finded.sw, finded.y - (finded.sh * 2), finded.x + finded.sw, finded.y))
            {
                my_enemy = finded;
            }
        }
        if (my_enemy != -1 && (type != 5 && type != 9 && type != 8))
        {
            my_enemy.hp -= damage;
            my_enemy.knock_power += myknock;
            my_enemy.knock_rot = direction;
            if (!explosive && !is_rocket && type != 6)
            {
                mybullet = instance_create(x + random(hspeed), y + random(vspeed), part_bullethit);
                if (type == 2)
                {
                    mybullet.sprite_index = sp_part_hitlaser;
                    mybullet.image_blend = c_red;
                    mybullet.sound = 62;
                }
                if (type == 3)
                {
                    mybullet.sprite_index = sp_part_hitlaser;
                    mybullet.image_blend = c_blue;
                    mybullet.sound = 62;
                }
                if (type == 4)
                {
                    mybullet.sprite_index = sp_part_hitlaser;
                    mybullet.image_blend = c_black;
                    mybullet.sound = 62;
                }
            }
            if (type != 5 && type != 9 && type != 8)
            {
                if (explosive || is_rocket || is_sniper || type == 6)
                {
                    myboom = instance_create(x, y + z, boom);
                    myboom.damage = damage;
                    myboom.scale = 0.5 + (0.5 * (is_rocket || type == 6));
                }
                instance_destroy();
            }
        }
    }
    var count = 0;
    if (is_array(count))
    {
        count = array_height_2d(shots);
    }
    if (type == 7)
    {
        for (var k = 0; k < array_height_2d(shots); k++)
        {
            if (shots[k, 4] == 1)
            {
                continue;
            }
            var X = shots[k, 0];
            var Y = shots[k, 1];
            var my_enemy = -1;
            for (var i = 0; i < instance_number(enemy); i++)
            {
                var finded = instance_find(enemy, i);
                if (point_in_rectangle(X, Y, finded.x - finded.sw, finded.y - (finded.sh * 2), finded.x + finded.sw, finded.y))
                {
                    my_enemy = finded;
                }
            }
            if (my_enemy != -1)
            {
                my_enemy.hp -= damage;
                my_enemy.knock_power += myknock;
                my_enemy.knock_rot = shots[k, 3];
                instance_create(X, Y, part_bullethit);
                shots[k, 4] = 1;
                if (explosive || is_rocket || is_sniper)
                {
                    myboom = instance_create(X, Y, boom);
                    myboom.damage = damage;
                    myboom.scale = 0.2;
                }
            }
        }
    }
}
