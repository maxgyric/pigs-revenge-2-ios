var sc = A * argument2;
var psX = 47 * sc;
var psY = 86 * sc;
var X = floor(-170 * sc);
var Y = floor(-140 * sc);
var im = 0;
for (var k = 0; k < 3; k++)
{
    for (var i = 0; i < 7; i++)
    {
        if (k == 0 && i == 0)
        {
            continue;
        }
        if (k == 0 && i == 6)
        {
            continue;
        }
        if (k == 2 && i == 0)
        {
            continue;
        }
        if (k == 2 && i == 1)
        {
            continue;
        }
        if (k == 2 && i == 5)
        {
            continue;
        }
        if (k == 2 && i == 6)
        {
            continue;
        }
        draw_sprite_ext(sp_logogame, im, argument0 + X + floor(i * psX), argument1 + Y + floor(k * psY), sc, sc, 0, c_white, 1);
        im++;
    }
}
