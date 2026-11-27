var S = 0.4;
var X = x;
var Y = y - (20 * S);
var goback = 0;
var look_dir = G.dir_shot;
var blink_ind = 0;
var pr_pos = walk_time * -xscale;
if (xscale == -1 && hspeed > 0)
{
    pr_pos = walk_time * xscale;
}
if (xscale == 1 && hspeed < 0)
{
    pr_pos = -pr_pos;
}
var boot_1_x = sin(pr_pos) * 3.5 * (speed / 2) * S;
var boot_1_y = sin(pr_pos + 1.5707963267948966) * 10 * (speed / 2) * S;
var boot_2_x = sin(pr_pos + pi) * 3.5 * (speed / 2) * S;
var boot_2_y = sin(pr_pos + 1.5707963267948966 + pi) * 10 * (speed / 2) * S;
if (boot_1_y > 0)
{
    boot_1_y = 0;
}
if (boot_2_y > 0)
{
    boot_2_y = 0;
}
if (abs(speed) > 0.1)
{
    walk_time++;
}
else
{
    walk_time = 0;
}
blinker++;
timer++;
var _add = clamp(cos(pr_pos / 5), 0, 999) * 12 * (speed / 8) * S;
var offset_y = (sin(timer / 4) * 4 * S) + _add;
var offset_y2 = (cos(timer / 4) * 4 * S) + _add;
if (blinker > 40)
{
    blink_ind = 1;
}
if (blinker > 50)
{
    blinker = 0;
}
if (G.ready_walk && !G.ready_shot)
{
    look_dir = direction;
}
if (look_dir > 10 && look_dir < 170)
{
    goback = 1;
}
if (look_dir > 90 && look_dir < 270)
{
    xscale = -1;
}
else
{
    xscale = 1;
}
draw_sprite_ext(sp_fbloom, 0, x, y + (4 * S), 2.8 * S, 0.9 * S, 0, c_black, 1);
var prev_a = draw_get_alpha();
if (immune > 0)
{
    draw_set_alpha(0.2 + sin(timer));
    immune--;
}
if (goback)
{
    DrawWeapon(S, X, Y, look_dir, xscale);
}
DS((X - (35 * S)) + boot_1_x, Y + boot_1_y + (15 * S), 66, goback, S, xscale, 0);
DS(X + (35 * S) + boot_2_x, Y + boot_2_y + (15 * S), 66, goback, S, xscale, 0);
DS((X - (35 * S)) + boot_1_x, Y + boot_1_y + (15 * S), 67, goback, S, xscale, sin(pr_pos) * 14 * (speed / 8));
DS(X + (35 * S) + boot_2_x, Y + boot_2_y + (15 * S), 67, goback, S, xscale, sin(pr_pos) * 14 * (speed / 8));
DS(X, (Y - (60 * S)) + offset_y, G.dress_avaible[G.selected_dress, 1], goback, S, xscale, 0);
var head_b = 0;
if (xscale == -1)
{
    head_b = 180;
}
var head_a = head_b + clamp((((look_dir - head_b) + 540) % 360) - 180, -25, 25);
DS(X, (Y - (85 * S)) + offset_y2, 70, goback, S * xscale, xscale, head_a);
if (!goback)
{
    if (blink_ind)
    {
        DS(X, (Y - (85 * S)) + offset_y2, 65, 2, S * xscale, xscale, head_a);
    }
    else
    {
        DS(X, (Y - (85 * S)) + offset_y2, 65, 0, S * xscale, xscale, head_a);
        DS(X, (Y - (85 * S)) + offset_y2, 65, 1, S * xscale, xscale, head_a);
    }
    DS(X, (Y - (85 * S)) + offset_y2, 71, 0, S * xscale, xscale, head_a);
    DS(X, (Y - (85 * S)) + offset_y2, 71, 1, S * xscale, xscale, head_a);
}
var h_a = G.selected_hat;
var h_b = G.hat_avaible[G.selected_hat, 1];
if (h_a != 0)
{
    if (!((h_a == 1 || h_a == 3) && goback))
    {
        DS(X, (Y - (85 * S)) + offset_y2, h_b, goback, S * xscale, xscale, head_a);
    }
}
if (!goback)
{
    DrawWeapon(S, X, Y, look_dir, xscale);
}
draw_set_alpha(prev_a);
