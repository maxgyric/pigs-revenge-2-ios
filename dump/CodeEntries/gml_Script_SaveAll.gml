ini_open("S");
var i = 0;
for (i = 0; i < array_height_2d(WPN); i++)
{
    ini_write_real("weapons", "w_" + string(i), weapon_avaible[WPN[i, 0]]);
}
for (i = 0; i < 4; i++)
{
    ini_write_real("weapons", "slot_" + string(i), weapon_slot[i]);
}
for (i = 0; i < array_height_2d(WPN); i++)
{
    for (var k = 0; k < 4; k++)
    {
        ini_write_real("weapons_", "upgrade_Weapon_N" + string(i) + "_Upgrade_N" + string(k), UW_map[i, k]);
    }
}
ini_write_real("weapons", "current_weapon", current_weapon);
ini_write_real("weapons", "selected_slot", selected_slot);
ini_write_real("_", "sounds", sounds);
ini_write_real("_", "music", music);
ini_write_real("_", "control_type_walk", control_type_walk);
ini_write_real("_", "control_type_shot", control_type_shot);
ini_write_real("_", "money", money);
ini_write_real("_", "gold", gold);
ini_write_real("_", "frags", frags);
ini_write_real("_", "expa", expa);
ini_write_real("_", "expa_levelnext", expa_next_level);
ini_write_real("_", "timetotal", total_time);
ini_write_real("_", "hero_level", hero_level);
ini_write_real("_", "currnet_dress", selected_dress);
ini_write_real("_", "current_hat", selected_hat);
ini_write_real("_", "lang", gamelang);
for (i = 0; i < 10; i++)
{
    ini_write_real("_", "dress_avaible_" + string(i), dress_avaible[i, 0]);
}
for (i = 0; i < 8; i++)
{
    ini_write_real("_", "hat_avaible_" + string(i), hat_avaible[i, 0]);
}
for (i = 0; i < 20; i++)
{
    ini_write_real("_", "ach" + string(i), ach_map[i]);
}
ini_write_real("_", "selected_stage", selected_stage);
ini_close();
