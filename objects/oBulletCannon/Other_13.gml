/// @description shoot a bullet
if(inView(360)) { audio_stop_sound(aShoot); snd(aShoot); }
var s = bulletSpd, d = image_angle;
with(instance_create_layer(x, y, "Bullets", oBullet)) {
	spd = s; dir = d; image_angle = d;
}
image_index = 1; a[2] = 60;

a[3] += delay;