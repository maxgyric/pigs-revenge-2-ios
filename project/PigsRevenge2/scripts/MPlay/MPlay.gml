function MPlay() {
    if (G.music)
    {
        if (argument0 == 1)
        {
            if (!audio_is_playing(__A(94)) && !audio_is_playing(__A(95)) && !audio_is_playing(__A(96)))
            {
                audio_play_sound(__A(choose(94, 95, 96)), 1, true);
            }
        }
    }
}
