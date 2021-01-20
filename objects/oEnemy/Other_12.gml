if(inView())
{
	audio_play_sound(aShoot, 0, false);
	var b = instance_create_layer(x, y, "Below", oProjectile);
	b.direction = barrageAngle; b.image_angle = barrageAngle; b.speed = bulletSpeed;
	b.colour = colour;
}
if(barrageAngle == barrageAngleTo)
{
	barrageResting = true;
	alarms[2] = barrageDelay;	
	var t = barrageAngleTo; barrageAngleTo = barrageAngleFrom;
	barrageAngleFrom = t;
	barrageAngle = barrageAngleFrom;
}
else
{
	barrageAngle = approach(barrageAngle, barrageAngleTo, 10);
	alarms[2] = barrageTick;
	barrageResting = false;
}
	