if ((M == 12 || M == 13) && map_visible)
{
    if (map_type == 0 || map_type == 1 || map_type == 6)
    {
        var col;
        switch (map_type)
        {
            case 0:
            case 6:
                col = make_color_rgb(185, 216, 132);
                break;
            case 1:
                col = make_color_rgb(104, 55, 123);
                break;
            case 7:
                col = make_color_rgb(90, 75, 65);
                break;
        }
        draw_rectangle_colour(view_xview[0] - 16, view_yview[0] - 16, view_xview[0] + view_wview[0] + 16, view_yview[0] + view_hview[0] + 16, col, col, col, col, 0);
    }
    if (map_type == 2 || map_type == 3 || map_type == 4 || map_type == 5 || map_type == 7 || map_type == 8)
    {
        var tex;
        switch (map_type)
        {
            case 2:
                tex = 208;
                break;
            case 3:
                tex = 211;
                break;
            case 4:
                tex = 209;
                break;
            case 5:
                tex = 212;
                break;
            case 7:
                tex = 28;
                break;
            case 8:
                tex = 210;
                break;
        }
        draw_sprite_tiled(tex, 0, 0, 0);
    }
    if (map_type != 4)
    {
        for (var i = 0; i < array_height_2d(map_props); i++)
        {
            if (map_props[i, 0] != -999)
            {
                draw_sprite_ext(map_props[i, 2], map_props[i, 3], map_props[i, 0], map_props[i, 1], 1, 1, 0, c_white, 1);
            }
        }
    }
}
