var X = 0;
var Y = 0;
var levels_count = max_levels;
var lev_start_cnt = selected_stage * 10;
var lev_end_cnt = lev_start_cnt + 10;
var max_page = (levels_count / 10) - 1;
var max_avaible_page = 0;
var counter = 0;
for (var i = 0; i < levels_count; i++)
{
    if (level_stat[i] != 0)
    {
        counter++;
        if (counter > 10)
        {
            counter = 1;
            max_avaible_page++;
        }
    }
}
while (levels_count < lev_end_cnt)
{
    lev_end_cnt--;
}
if (keyboard_check(vk_down))
{
    for (var i = 0; i < max_levels; i++)
    {
        if (level_stat[i] == 0)
        {
            level_stat[i] = choose(1, 2, 3, 4);
            i = max_levels + 1;
        }
        else
        {
            continue;
        }
    }
}
DT(CW, 60 * A, L[143] + string(selected_stage + 1), 1.5);
for (var i = lev_start_cnt; i < lev_end_cnt; i++)
{
    var pos_x = (CW - (250 * A)) + (X * 125 * A);
    var pos_y = (CH - (100 * A)) + (Y * 170 * A) + (cos((i * 15) + (selected_stage * 3)) * 25 * A);
    var stat = level_stat[i];
    var yadd = -abs(sin(F / 10) * 15 * (stat == 1)) * A;
    if (BT(pos_x, pos_y + yadd, 61, i, "", 1))
    {
        if (level_stat[i] != 0)
        {
            V[1] = 1;
            _Sout = 0.99;
            play_level = i;
        }
    }
    if (stat != 0)
    {
        if (stat != 1)
        {
            draw_sprite_ext(sp_mlev_complete, 0, pos_x, pos_y, A, A, 0, c_white, _S);
            draw_sprite_ext(sp_mlev_star, stat - 2, pos_x, pos_y, A, A, 0, c_white, _S);
        }
        else
        {
            draw_set_font(F1);
            var SC = A * 1.5 * _S;
            var prev_a = draw_get_alpha();
            draw_set_alpha(_S);
            draw_text_ext_transformed(pos_x, (pos_y - (25 * A)) + (5 * A) + yadd, i + 1, 0, 100, SC, SC, 0);
            draw_set_alpha(prev_a);
            draw_set_font(F0);
        }
    }
    else
    {
        draw_sprite_ext(sp_shop_locked, 0, pos_x + 2, pos_y + 2, A, A, -10, c_black, _S / 2);
        draw_sprite_ext(sp_shop_locked, 0, pos_x + 2, pos_y + 2, -A, A, -10, c_black, _S / 2);
        draw_sprite_ext(sp_shop_locked, 0, pos_x, pos_y, A, A, -10, c_white, _S);
        draw_sprite_ext(sp_shop_locked, 0, pos_x, pos_y, -A, A, -10, c_white, _S);
    }
    X++;
    if (X == 5)
    {
        X = 0;
        Y++;
    }
}
if (selected_stage > 0)
{
    if (BT(70 * A, CH, 63, 0, L[144], 1))
    {
        selected_stage--;
    }
}
if (selected_stage < max_page && selected_stage < max_avaible_page)
{
    if (BT(W - (70 * A), CH - (50 * A), 63, 1, L[145], 1))
    {
        selected_stage++;
    }
}
if (selected_stage < max_page && selected_stage < max_avaible_page)
{
    if (BT(W - (70 * A), CH + (50 * A), 63, 2, L[146], 1))
    {
        selected_stage = max_avaible_page;
    }
}
