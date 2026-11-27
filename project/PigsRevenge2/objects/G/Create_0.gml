__compat_init();
draw_set_font(F0);
SA(0);
W = window_get_width();
H = window_get_height();
CW = W / 2;
CH = H / 2;
W1 = W * 0.333334;
W2 = W * 0.666667;
H1 = H * 0.333334;
H2 = H * 0.666667;
A = H / 574;
_Sin = 0;
_Sout = 1;
_S = 0;
TReady = 0;
AllowPress = 1;
M = 0;
V = 0;
F = 0;
L = 0;
NextMenuAfterLoading = 0;
F_b = 0;
V_b = 0;
part_b = 0;
game_active = 0;
map_type = 0;
map_visible = 1;
map_props = 0;
map_micro = 0;
start_walk = 0;
start_shot = 0;
dir_walk = 0;
dir_shot = 0;
device_walk = -1;
device_shot = -1;
ready_shot = 0;
ready_walk = 0;
v_keys_maked = 0;
v_keys = 0;
ini_open("S");
sounds = ini_read_real("_", "sounds", 1);
music = ini_read_real("_", "music", 1);
control_type_walk = ini_read_real("_", "control_type_walk", 0);
control_type_shot = ini_read_real("_", "control_type_shot", 0);
money = ini_read_real("_", "money", 0);
gold = ini_read_real("_", "gold", 0);
frags = ini_read_real("_", "frags", 0);
expa = ini_read_real("_", "expa", 0);
expa_next_level = ini_read_real("_", "expa_levelnext", 50);
total_time = ini_read_real("_", "timetotal", 0);
hero_level = ini_read_real("_", "hero_level", 0);
selected_dress = ini_read_real("_", "currnet_dress", 0);
selected_hat = ini_read_real("_", "current_hat", 0);
for (var i = 0; i < 10; i++)
{
    dress_avaible[i, 0] = ini_read_real("_", "dress_avaible_" + string(i), 0);
}
for (var i = 0; i < 8; i++)
{
    hat_avaible[i, 0] = ini_read_real("_", "hat_avaible_" + string(i), 0);
}
for (var i = 0; i < 20; i++)
{
    ach_map[i] = ini_read_real("_", "ach" + string(i), 0);
}
dress_avaible[0, 0] = 1;
hat_avaible[0, 0] = 1;
gamelang = ini_read_real("_", "lang", 0);
LangLoad(gamelang);
selected_stage = ini_read_real("_", "selected_stage", 0);
max_levels = 2000;
play_level = 0;
ini_close();
if (os_type == os_windows)
{
    control_type_shot = 1;
}
start_sound_chain = 0;
start_sound_flame = 0;
combo = 0;
combo_x = 0;
is_win = 0;
level_up_x = 0;
check_ach = 1;
aver_fps = 30;
hint_time = 0;
hint_mess = 0;
hint_a = 0;
randomize();
WPN = 0;
WeaponAdd(0, "Bat", 10, 0, 2, 1, 10, 0, 84, 0, 0, 0, 190, 48, -1, 7);
WeaponAdd(1, "Axe", 1500, 0, 4, 1, 20, 0, 85, 0, 0, 0, 240, 48, -1, 10);
WeaponAdd(2, "Machete", 3000, 0, 2, 1, 5, 0, 86, 0, 0, 0, 180, 48, -1, 5);
WeaponAdd(3, "Sword", 4500, 0, 5, 1, 15, 0, 87, 0, 0, 0, 280, 48, -1, 4);
WeaponAdd(4, "Chainsaw", 40000, 0, 2, 300, 2, 90, 88, 2, 0, -4, 175, 34, 11, 3);
WeaponAdd(5, "Cool sword", 0, 1, 50, 1, 15, 0, 89, 0, 0, 0, 220, 37, -1, 4);
WeaponAdd(6, "Magic finger", 0, 1, 35, 1, 10, 0, 90, 4, 0, 0, 200, 48, -1, 15);
WeaponAdd(7, "Classic gun", 1000, 0, 3, 14, 9, 40, 91, 1, 0, 8, 110, 4, 23, 4);
WeaponAdd(8, "Blue pistol", 5000, 0, 3, 20, 7, 50, 92, 1, 0, 8, 115, 5, 23, 4);
WeaponAdd(9, "Fast pistol", 15000, 0, 4, 40, 5, 60, 93, 1, 0, 8, 110, 36, 23, 4);
WeaponAdd(10, "Revenger", 24000, 0, 7, 14, 15, 80, 94, 1, 0, 8, 133, 32, 20, 6);
WeaponAdd(11, "Gold guy", 0, 5, 20, 14, 9, 50, 95, 1, 0, 8, 133, 32, 20, 8);
WeaponAdd(12, "Blackpower", 31000, 0, 9, 12, 12, 60, 96, 1, 0, 12, 150, 41, 24, 7);
WeaponAdd(13, "Super pistol", 0, 2, 45, 10, 15, 30, 97, 1, 0, 8, 150, 42, 23, 10);
WeaponAdd(14, "Shorty", 150, 0, 4, 4, 8, 70, 98, 1, 0, 6, 180, 27, 25, 1);
WeaponAdd(15, "Crusher", 12000, 0, 2, 8, 30, 45, 99, 2, 0, 8, 210, 33, 40, 1);
WeaponAdd(16, "Elephant", 15000, 0, 40, 10, 30, 100, 100, 2, 0, 8, 190, 7, 20, 8);
WeaponAdd(17, "Super crusher", 50000, 0, 1, 20, 6, 40, 101, 2, 0, 12, 190, 28, 16, 1);
WeaponAdd(18, "BIG MASTER", 0, 2, 10, 8, 20, 50, 102, 2, 0, 8, 148, 46, 26, 2);
WeaponAdd(19, "Killer", 80000, 0, 40, 5, 30, 120, 103, 2, 0, 8, 230, 14, 20, 10);
WeaponAdd(20, "Destroyer", 0, 4, 100, 24, 20, 40, 104, 2, 0, 12, 140, 14, 24, 8);
WeaponAdd(21, "Tiny gun", 25000, 0, 2, 30, 3, 30, 105, 2, 0, 12, 150, 15, 26, 1);
WeaponAdd(22, "Classic boy", 40000, 0, 4, 30, 4, 50, 106, 2, 0, 10, 190, 38, 26, 1);
WeaponAdd(23, "Fast maniac", 50000, 0, 2, 20, 2, 30, 107, 3, 0, 6, 128, 49, 26, 1);
WeaponAdd(24, "Old friend", 80000, 0, 5, 30, 4, 50, 108, 2, 0, 9, 230, 29, 17, 2);
WeaponAdd(25, "Sand avenger", 90000, 0, 7, 30, 5, 60, 109, 2, 0, 10, 190, 45, 26, 2);
WeaponAdd(26, "Momentum", 150000, 0, 4, 100, 2, 150, 110, 2, 0, 9, 230, 39, 21, 1);
WeaponAdd(27, "Blue death", 0, 4, 10, 30, 4, 40, 111, 3, 0, 12, 128, 47, 26, 4);
WeaponAdd(28, "Balista", 70000, 0, 25, 10, 10, 60, 112, 3, 0, 12, 108, 31, 19, 1);
WeaponAdd(29, "Boomer", 60000, 0, 100, 10, 20, 60, 113, 3, 0, 4, 150, 35, 22, 1);
WeaponAdd(30, "Monster gun", 500000, 0, 4, 100, 2, 150, 114, 2, 0, -7, 210, 39, 21, 1);
WeaponAdd(31, "Exploder", 500000, 0, 100, 1, 50, 60, 115, 2, 0, 10, 128, 43, 22, 1);
WeaponAdd(32, "Firebug", 750000, 0, 1, 100, 3, 120, 116, 2, 0, 4, 145, 34, 21, 0.1);
WeaponAdd(33, "Blaster", 0, 6, 30, 20, 5, 40, 117, 2, 0, 8, 125, 30, 18, 2);
WeaponAdd(34, "Super blaster", 0, 6, 90, 10, 10, 60, 118, 2, 0, 8, 140, 44, 18, 5);
ini_open("S");
current_weapon = ini_read_real("weapons", "current_weapon", 0);
for (var i = 0; i < __c_array_height_2d(WPN); i++)
{
    weapon_avaible[WPN[i, 0]] = ini_read_real("weapons", "w_" + string(i), 0);
}
for (var i = 0; i < 4; i++)
{
    weapon_slot[i] = ini_read_real("weapons", "slot_" + string(i), -1);
}
weapon_avaible[0] = 1;
if (weapon_slot[0] == -1)
{
    weapon_slot[0] = 0;
}
weapon_avaible[14] = 1;
if (weapon_slot[1] == -1)
{
    weapon_slot[1] = 14;
}
selected_slot = ini_read_real("weapons", "selected_slot", 0);
for (var i = 0; i < __c_array_height_2d(WPN); i++)
{
    for (var k = 0; k < 4; k++)
    {
        UW_map[i, k] = ini_read_real("weapons_", "upgrade_Weapon_N" + string(i) + "_Upgrade_N" + string(k), 0);
    }
}
ini_close();
battle_kills = 0;
battle_time = 0;
battle_money = 0;
battle_damage_get = 0;
got_medal = 0;
if (os_type == os_windows)
{
    window_set_size(display_get_width() - 500, display_get_height() - 400);
    window_set_position(200, 200);
}
for (var i = 0; i < __c_array_height_2d(dress_avaible); i++)
{
    var sp = 73;
    switch (i)
    {
        case 0:
            sp = 73;
            break;
        case 1:
            sp = 187;
            break;
        case 2:
            sp = 188;
            break;
        case 3:
            sp = 189;
            break;
        case 4:
            sp = 190;
            break;
        case 5:
            sp = 191;
            break;
        case 6:
            sp = 192;
            break;
        case 7:
            sp = 193;
            break;
        case 8:
            sp = 194;
            break;
        case 9:
            sp = 195;
            break;
    }
    dress_avaible[i, 1] = sp;
}
for (var i = 0; i < __c_array_height_2d(hat_avaible); i++)
{
    var sp = 196;
    switch (i)
    {
        case 0:
            sp = 196;
            break;
        case 1:
            sp = 196;
            break;
        case 2:
            sp = 197;
            break;
        case 3:
            sp = 198;
            break;
        case 4:
            sp = 199;
            break;
        case 5:
            sp = 200;
            break;
        case 6:
            sp = 201;
            break;
        case 7:
            sp = 202;
            break;
    }
    hat_avaible[i, 1] = sp;
}
cutscene_show = 0;
cutscene_f = 0;
cutscene_type = 0;
cutscene_v = 0;
Init("56d8596204b016442647f071", "16c476dc9c63d76b6fdf315c73f61649a170897c");
quest_id = 0;
quest_v = 0;
quest_f = 0;
quest_data = 0;
enemy_sprite_0 = 139;
enemy_sprite_0a = 140;
enemy_sprite_1 = 141;
enemy_sprite_1a = 142;
enemy_sprite_2 = 143;
enemy_sprite_2a = 144;
enemy_sprite_3 = 157;
enemy_sprite_3a = 158;
weath_t = 0;
weath_f = 0;
weath_v = 0;
weath_time = 0;
trans_type = 0;
trans_step = 0;
trans_mess = 0;
trans_timeout = 0;
pwrup[0] = 0;
pwrup[1] = 0;
pwrup[2] = 0;
pwrup[3] = 0;
pwrup[4] = 0;
adm_open = 0;
adm_money = 0;
adm_god = 0;
adm_ammo = 0;
adm_onehit = 0;
adm_freeze = 0;
adm_fps = 0;
adm_lev = 0;
adm_reset = 0;
adm_msg = "";
adm_msg_t = 0;
