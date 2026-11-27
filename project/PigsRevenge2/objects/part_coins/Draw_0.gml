F++;
for (var i = 0; i < count; i++)
{
    draw_sprite_ext(__S(42), F / 2, par[i, 0], par[i, 1], 0.35, 0.35, 0, c_white, 1 - (F / 120));
    par[i, 0] += par[i, 2];
    par[i, 1] += par[i, 3];
    par[i, 3] += 0.5;
    if (par[i, 1] > par[i, 4])
    {
        par[i, 3] = -par[i, 3] * 0.7;
        par[i, 2] *= 0.8;
    }
}
if (F > 120)
{
    instance_destroy();
}
if (fps < 25)
{
    F++;
}
