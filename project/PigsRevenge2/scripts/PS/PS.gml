function PS() {
    if (G.sounds)
    {
        audio_sound_pitch(__A(argument0), random_range(0.9, 1.1));
        audio_play_sound(__A(argument0), 1, false);
    }
}
