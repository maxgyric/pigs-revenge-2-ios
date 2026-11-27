xscale = 1;
blinker = 0;
timer = 0;
walk_time = 0;
footstep = 0;
hp = 3;
immune = 30;
wait_next_shot = 0;
for (var i = 0; i < 4; i++)
{
    if (G.weapon_slot[i] != -1)
    {
        ammo_in_slot[i] = G.WPN[G.weapon_slot[i], 5];
    }
    else
    {
        ammo_in_slot[i] = 0;
    }
}
selected_slot = 0;
reloading_time = 0;
shot_second = 0;
last_shot_time = 999;
sound_isplayed = 0;
event_shot = 0;
show_ammo = 0;
PS(G.WPN[G.current_weapon, 14]);
