if (scale > 0.5)
{
    PS(8);
}
else
{
    audio_stop_sound(__A(8));
    PS_alt(8);
}
image_xscale = scale;
image_yscale = image_xscale;
visible = true;
