if (G.sounds)
{
    audio_sound_pitch(argument0, random_range(3.8, 5));
    audio_sound_gain(argument0, 0.35, 0);
    audio_play_sound(argument0, 1, false);
}
