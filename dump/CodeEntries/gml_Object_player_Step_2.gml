var pw = 0;
if (G.pwrup[0] > 0)
{
    pw = 3;
}
if (os_type == os_windows)
{
    if (G.ready_walk)
    {
        motion_add(G.dir_walk, 3);
        direction = G.dir_walk;
    }
    else if (!(keyboard_check(ord("W")) || keyboard_check(ord("S")) || keyboard_check(ord("A")) || keyboard_check(ord("D"))))
    {
        speed *= 0.65;
    }
}
else if (G.ready_walk)
{
    motion_add(G.dir_walk, 3);
    direction = G.dir_walk;
}
if (keyboard_check(ord("W")))
{
    motion_add(90, 3);
}
if (keyboard_check(ord("D")))
{
    motion_add(0, 3);
}
if (keyboard_check(ord("A")))
{
    motion_add(180, 3);
}
if (keyboard_check(ord("S")))
{
    motion_add(270, 3);
}
if (keyboard_check(ord("Q")))
{
    motion_add(135, 3);
}
if (keyboard_check(ord("E")))
{
    motion_add(45, 3);
}
if (keyboard_check(ord("Z")))
{
    motion_add(225, 3);
}
if (keyboard_check(ord("C")))
{
    motion_add(315, 3);
}
speed = clamp(speed, -5.5 - pw, 5.5 + pw);
x = clamp(x, 16, room_width - 16);
y = clamp(y, 96, room_height - 16);
depth = -y;
pw = 0;
if (G.pwrup[0] > 0)
{
    pw = 1;
}
last_shot_time++;
selected_slot = G.selected_slot;
if (wait_next_shot > 0)
{
    wait_next_shot--;
}
if (reloading_time > -1)
{
    if (reloading_time < 15 && !sound_isplayed)
    {
        if (G.WPN[G.current_weapon, 14] != -1)
        {
            PS(G.WPN[G.current_weapon, 14]);
        }
        sound_isplayed = 1;
    }
    if (reloading_time == 0)
    {
        ammo_in_slot[selected_slot] = G.WPN[G.current_weapon, 5];
        ammo_in_slot[selected_slot] += (ceil(G.WPN[G.current_weapon, 5]) / 3) * G.UW_map[G.current_weapon, 1];
        ammo_in_slot[selected_slot] = ceil(ammo_in_slot[selected_slot]);
        sound_isplayed = 0;
    }
    reloading_time--;
}
if (G.ready_shot && wait_next_shot <= 0 && ammo_in_slot[selected_slot] > 0 && reloading_time <= 0)
{
    wait_next_shot = G.WPN[G.current_weapon, 6];
    wait_next_shot -= (ceil(G.WPN[G.current_weapon, 6] * G.UW_map[G.current_weapon, 2]) / 6);
    if (pw)
    {
        wait_next_shot /= 2;
    }
    PS(G.WPN[G.current_weapon, 13]);
    ammo_in_slot[selected_slot]--;
    shot_second = !shot_second;
    last_shot_time = 0;
    event_shot = 1;
}
else if (ammo_in_slot[selected_slot] <= 0 && reloading_time == -1)
{
    reloading_time = G.WPN[G.current_weapon, 7];
    reloading_time -= (ceil(G.WPN[G.current_weapon, 7] * G.UW_map[G.current_weapon, 3]) / 6);
    reloading_time -= ((reloading_time / 2) * pw);
    reloading_time = floor(reloading_time);
    if (reloading_time < 1)
    {
        reloading_time = 1;
    }
}
if (speed > 0)
{
    footstep += (speed / 8);
}
else
{
    footstep = 0;
}
if (footstep > 3)
{
    footstep = 0;
    PS_alt(choose(50, 51, 52, 53));
    instance_create(x, y, o_part_footstep);
}
if (walk_time == 1 || (speed < 2.7 && walk_time > 20 && !(audio_is_playing(SnStepConcShoosh0) || audio_is_playing(SnStepConcShoosh1) || audio_is_playing(SnStepConcShoosh2) || audio_is_playing(SnStepConcShoosh3))))
{
    PS_alt(choose(54, 55, 56, 57));
}
var count = instance_number(enemy);
if (immune <= 0 && G.pwrup[2] <= 0 && !G.is_win && !(G.level_up_x > 0 && G.level_up_x < 590))
{
    for (var i = 0; i < count; i++)
    {
        var en = instance_find(enemy, i);
        if (point_in_rectangle(x, y, en.x - en.sw, en.y - 2, en.x + en.sw, en.y + 2))
        {
            PS(78);
            immune = 90;
            hp--;
            if (en.imboss)
            {
                hp--;
            }
            G.battle_damage_get++;
            i = 9999;
        }
    }
}
if (hp < 0)
{
    with (enemy)
    {
        my_target = -1;
    }
    instance_create(x, y, part_deadplayer);
    instance_destroy();
}
if (!place_free(x + hspeed, y))
{
    x = xprevious;
}
if (!place_free(x, y + vspeed))
{
    y = yprevious;
}
