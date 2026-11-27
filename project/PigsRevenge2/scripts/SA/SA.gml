function SA() {
    switch (argument0)
    {
        case 0:
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            break;
        case 1:
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            break;
        case 2:
            draw_set_halign(fa_center);
            draw_set_valign(fa_top);
            break;
    }
}
