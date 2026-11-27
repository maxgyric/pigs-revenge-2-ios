y -= 3;
x = xstart + (sin(image_xscale / 2) * 10);
image_xscale = clamp(1 + sin((image_alpha * 5) + 5), 0, 2);
image_alpha -= 0.04;
if (image_alpha < 0)
{
    instance_destroy();
}
