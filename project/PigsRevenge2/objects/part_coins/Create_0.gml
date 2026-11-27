__compat_init();
par = 0;
F = 0;
count = 4;
for (var i = 0; i < count; i++)
{
    par[i, 0] = x + random_range(-4, 4);
    par[i, 1] = y + random_range(-2, 2);
    par[i, 2] = random_range(-2, 2);
    par[i, 3] = random_range(-5, -10);
    par[i, 4] = y + random_range(-4, 4);
}
