alarm[0] = 30;
part = 0;
for (var i = 0; i < 5; i++)
{
    part[i, 0] = x + random_range(-30, 30);
    part[i, 1] = y + random_range(-10, 10);
    part[i, 2] = random_range(-1, 1);
    part[i, 3] = random_range(-1, -3);
    part[i, 4] = 0.1;
}
