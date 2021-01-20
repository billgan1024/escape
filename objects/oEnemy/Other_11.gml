if(inView())
{
	audio_play_sound(aShoot, 0, false);
	var b = instance_create_layer(x, y, "Below", oProjectile);
	b.direction = fireAngle; b.image_angle = fireAngle; b.speed = bulletSpeed;
	b.colour = colour;
	if(triple)
	{
		var b1 = instance_create_layer(x, y, "Below", oProjectile);
		b1.direction = fireAngle-15; b1.image_angle = fireAngle-15; b1.speed = bulletSpeed;
		b1.colour = colour;
		var b2 = instance_create_layer(x, y, "Below", oProjectile);
		b2.direction = fireAngle+15; b2.image_angle = fireAngle+15; b2.speed = bulletSpeed;
		b2.colour = colour;
	}
}
alarms[1] += fireDelay;