hp_start = 4;
hp = hp_start;
reward = 2;
sprite[0] = G.enemy_sprite_0;
sprite[1] = G.enemy_sprite_0a;
var mt = choose(0, 1, 2);
switch (mt)
{
    case 0:
        sprite[0] = G.enemy_sprite_0;
        sprite[1] = G.enemy_sprite_0a;
        break;
    case 1:
        sprite[0] = G.enemy_sprite_1;
        sprite[1] = G.enemy_sprite_1a;
        break;
    case 2:
        sprite[0] = G.enemy_sprite_2;
        sprite[1] = G.enemy_sprite_2a;
        break;
    case 3:
        sprite[0] = G.enemy_sprite_3;
        sprite[1] = G.enemy_sprite_3a;
        break;
}
color = 16777215;
scale = 0.9;
imboss = 0;
if (sprite[0] == 141)
{
    scale += 0.4;
}
image_speed = sprite_get_number(sprite[0]) / 10;
sw = (sprite_get_width(sprite[0]) / 2) * scale;
sh = (sprite_get_height(sprite[0]) / 2) * scale;
xscale = 1;
goback = 0;
F = 0;
last_proj = 0;
flame = 0;
flame_start = 0;
flame_damage = 0;
knock_power = 0;
knock_rot = 0;
prev_hp = hp;
my_voice = 0;
graphics_walk = random(4);
played_sound_panic = 0;
my_target = -1;
if (instance_exists(player))
{
    my_target = instance_nearest(x, y, player);
}
look_dir = point_direction(x, y, my_target.x, my_target.y);
var LE = G.play_level;
var add_hp = hp_start * (LE / 100);
hp_start += add_hp;
reward += add_hp;
hp_start = ceil(hp_start);
reward = ceil(reward);
hp = hp_start;
if (G.quest_id == 2)
{
    reward *= 0.35;
    reward = ceil(reward);
}
