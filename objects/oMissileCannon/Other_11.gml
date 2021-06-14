/// @description shoot a missile
//show_debug_message(image_angle);
audio_stop_sound(aLaunch); snd(aLaunch); 
with(instance_create_layer(x, y, "Bullets", oMissile)) {
	spd = other.bulletSpd; dir = other.image_angle; image_angle = dir;
}
image_index = 1; a[2] = 60;

a[1] += delay;