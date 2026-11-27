__compat_init();
type = 0;
damage = 0;
dir = 0;
depth = -y - 40;
state = 0;
is_sniper = 0;
explosive = 0;
is_rocket = 0;
myknock = 0;
type_created = G.WPN[G.current_weapon, 0];
if (instance_exists(player))
{
    var myp = instance_nearest(x, y, player);
    dir = G.dir_shot;
    damage = G.WPN[G.current_weapon, 4];
    myknock = G.WPN[G.current_weapon, 15];
    switch (G.WPN[G.current_weapon, 0])
    {
        case 28:
            type = 1;
            break;
        case 19:
        case 16:
            type = 0;
            is_sniper = 1;
            break;
        case 13:
            type = 2;
            break;
        case 33:
            type = 3;
            break;
        case 34:
            type = 4;
            break;
        case 0:
        case 1:
        case 2:
        case 3:
        case 5:
        case 6:
            type = 5;
            break;
        case 29:
            type = 6;
            break;
        case 14:
        case 15:
        case 17:
        case 18:
            type = 7;
            break;
        case 32:
            type = 8;
            break;
        case 4:
            type = 9;
            break;
        default:
            type = 0;
            break;
    }
}
if (G.WPN[G.current_weapon, 0] == 11 || G.WPN[G.current_weapon, 0] == 20 || G.WPN[G.current_weapon, 0] == 18 || G.WPN[G.current_weapon, 0] == 27 || G.WPN[G.current_weapon, 0] == 31 || type == 1)
{
    explosive = 1;
}
if (G.WPN[G.current_weapon, 0] == 31)
{
    is_rocket = 1;
}
switch (type)
{
    case 2:
    case 3:
    case 4:
        speed = 60 + random_range(-4, 4);
        camera_set_view_angle(view_camera[0], camera_get_view_angle(view_camera[0]) + (random_range(1, 2) * choose(1, -1)));
        break;
    case 5:
        speed = -6;
        break;
    case 6:
        speed = 6;
        break;
    case 7:
        speed = 5;
        camera_set_view_angle(view_camera[0], camera_get_view_angle(view_camera[0]) + (random_range(4, 8) * choose(1, -1)));
        break;
    case 9:
        speed = -6;
        break;
    case 8:
        speed = 6;
        break;
    default:
        speed = 50 + random_range(-1, 1);
        camera_set_view_angle(view_camera[0], camera_get_view_angle(view_camera[0]) + (random_range(1, 3) * choose(1, -1)));
        break;
}
if (G.WPN[G.current_weapon, 0] == 31)
{
    speed = 22;
}
direction = G.dir_shot;
if (type == 0)
{
    direction += random_range(-1, 1);
}
F = 0;
F_dest = 0;
rand_rot = random(360);
z = -20;
zspeed = -10;
zgravity = 1;
if (type == 7)
{
    shots = 0;
    var shots_count = 5;
    if (G.WPN[G.current_weapon, 0] == 18)
    {
        shots_count = 10;
    }
    for (var i = 0; i < shots_count; i++)
    {
        shots[i, 0] = x;
        shots[i, 1] = y;
        shots[i, 2] = random_range(25, 30);
        shots[i, 3] = direction + random_range(-15, 15);
        shots[i, 4] = 0;
    }
}
damage += ((ceil(ceil(G.WPN[type_created, 4]) + G.UW_map[type_created, 0]) / 3) * G.UW_map[type_created, 0]);
damage = ceil(damage);
