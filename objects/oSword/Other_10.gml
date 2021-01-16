if(instance_exists(oPlayer))
{
	x = oPlayer.x;
	y = oPlayer.y;
	if(oPlayer.isAttacking)
	{
		image_alpha = 1;
		image_yscale = oPlayer.atkDir ? -1 : 1;
		image_angle = oPlayer.swordAngle;	
	}
	else image_alpha = 0;
}
else
{
	image_alpha = 0;
}