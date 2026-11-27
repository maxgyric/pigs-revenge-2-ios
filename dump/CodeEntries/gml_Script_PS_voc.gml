if (G.sounds)
{
    audio_sound_pitch(argument0, random_range(0.7, 1.3));
    audio_sound_gain(argument0, 0.35, 1);
    my_voice = audio_play_sound(argument0, 1, false);
}
