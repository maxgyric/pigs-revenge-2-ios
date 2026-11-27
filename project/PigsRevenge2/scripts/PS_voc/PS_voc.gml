function PS_voc() {
    if (G.sounds)
    {
        audio_sound_pitch(__A(argument0), random_range(0.7, 1.3));
        audio_sound_gain(__A(argument0), 0.35, 1);
        my_voice = audio_play_sound(__A(argument0), 1, false);
    }
}
