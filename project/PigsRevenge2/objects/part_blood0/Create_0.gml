__compat_init();
image_angle = random(360);
audio_stop_sound(__A(91));
audio_stop_sound(__A(90));
audio_stop_sound(__A(89));
audio_stop_sound(__A(88));
var snd = choose(91, 90, 89, 88);
PS(snd);
