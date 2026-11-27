for (var i = 0; i < 5; i++)
{
    part[i, 0] += part[i, 2];
    part[i, 1] += part[i, 3];
    part[i, 4] -= random(0.015);
}
