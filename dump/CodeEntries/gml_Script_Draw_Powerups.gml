for (var i = 0; i < 5; i++)
{
    if (pwrup[i] <= 0)
    {
        continue;
    }
    var S;
    switch (i)
    {
        case 0:
            S = 218;
            break;
        case 1:
            S = 219;
            break;
        case 2:
            S = 220;
            break;
        case 3:
            S = 221;
            break;
        case 4:
            S = 51;
            break;
    }
    var Y = (200 * A) + (40 * i * A);
    var SC = (0.6 - (0.2 * (i == 4))) * A;
    draw_sprite_ext(S, 0, W - (40 * A), Y, SC, SC, 0, c_white, _S);
    draw_set_halign(fa_right);
    DT(W - (65 * A), Y, L[148 + i] + " " + string(ceil(pwrup[i] / 30)), 0.6);
    draw_set_halign(fa_center);
}
