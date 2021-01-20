alpha = smooth_approach(alpha, image_alpha, 0.2);
if(instance_exists(oPlayer))
{
	x = oPlayer.x;
	y = oPlayer.y;
	if(oPlayer.isAttacking)
	{
		image_alpha = 1;
		image_yscale = oPlayer.atkDir ? -1 : 1;
		image_angle = oPlayer.swordAngle;	
		if(place_meeting(x, y, oProjectile))
		{
			var b = instance_nearest(x, y, oProjectile);
			b.direction = oPlayer.swordDir; b.friendly = true;
			b.image_angle = oPlayer.swordDir;
		}
	}
	else image_alpha = 0;
}
else
{
	image_alpha = 0;
}