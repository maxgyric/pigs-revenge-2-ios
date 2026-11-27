function PS_alt() {
    if (G.sounds)
    {
        audio_sound_pitch(__A(argument0), random_range(3.8, 5));
        audio_sound_gain(__A(argument0), 0.35, 0);
        audio_play_sound(__A(argument0), 1, false);
    }
}
