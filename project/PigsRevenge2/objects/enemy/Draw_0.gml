var shc = 15 * scale;
var sa = sin(graphics_walk / 2) * 7 * scale;
draw_sprite_pos(__S(80), 0, x - sw, y - shc, x + sw, y - shc, x + sw, y + shc, x - sw, y + shc, image_alpha);
draw_sprite_pos(__S(sprite[goback]), image_index, x - (sw * xscale), (y - (sh * 2)) + sa, x + (sw * xscale), (y - (sh * 2)) + sa, x + (sw * xscale), y, x - (sw * xscale), y, image_alpha);
if (hp_start > hp)
{
    draw_rectangle_colour(x - sw, y - (sh * 2) - 15, x + sw, y - (sh * 2) - 25, c_black, c_black, c_black, c_black, 0);
    draw_rectangle_colour((x - sw) + 1, y - (sh * 2) - 16, (x - sw) + (sw * 2 * clamp(hp / hp_start, 0, 1)), y - (sh * 2) - 24, c_lime, c_lime, c_lime, c_lime, 0);
}
if (flame > 0)
{
    draw_sprite_ext(__S(79), 0, x, y - sh, sw / 30, sw / 30, 0, c_orange, flame / 10);
    draw_sprite_ext(__S(129), (F / 2) + 5, x - (sw / 2), y - sh, (0.5 - (1 / sw)) * flame_start, (0.5 - (1 / sw)) * flame_start, 0, c_white, flame / 30);
    draw_sprite_ext(__S(129), F / 2, x + (sw / 2), y - sh, (0.5 - (1 / sw)) * flame_start, (0.5 - (1 / sw)) * flame_start, 0, c_white, flame / 30);
    draw_sprite_ext(__S(129), (F / 2) + 10, x, y - sh, (1 - (1 / sw)) * flame_start, (1 - (1 / sw)) * flame_start, 0, c_white, flame / 30);
}
