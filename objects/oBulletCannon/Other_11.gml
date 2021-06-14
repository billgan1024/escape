/// @description shoot a bullet
audio_stop_sound(aShoot); snd(aShoot);
with(instance_create_layer(x, y, "Bullets", oBullet)) {
	spd = other.bulletSpd; dir = other.image_angle; image_angle = dir;
}
image_index = 1; a[2] = 60;

a[1] += delay;