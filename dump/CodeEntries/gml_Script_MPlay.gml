if (G.music)
{
    if (argument0 == 1)
    {
        if (!audio_is_playing(mus_0) && !audio_is_playing(mus_1) && !audio_is_playing(mus_2))
        {
            audio_play_sound(choose(mus_0, mus_1, mus_2), 1, true);
        }
    }
}
