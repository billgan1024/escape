/// @description shoot a missile
audio_stop_sound(aLaunch); snd(aLaunch);
var s = bulletSpd, d = image_angle;
with(instance_create_layer(x, y, "Bullets", oMissile)) {
	spd = s; dir = d; image_angle = d;
}
image_index = 1; a[2] = 60;

a[1] += delay;