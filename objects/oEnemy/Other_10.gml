hsp = moveSpd*dir;
vsp = approach(vsp, maxGrav, grav);

if(instance_exists(oPlayer))
{
	if(!collision_line(x, y, oPlayer.x, oPlayer.y, oGround, false, false))
	{
		fireAngle = angle_approach(fireAngle, 
			point_direction(x, y, oPlayer.x, oPlayer.y), 3);
	}
	else fireAngle = dir == 1 ? 0 : 180;
}
else
{
	fireAngle = dir == 1 ? 0 : 180;
}
collision();
if(place_meeting(x-1, y, oGround) || 
	place_meeting(x+1, y, oGround) ||
	place_meeting(x-1, y, oInvis) || 
	place_meeting(x+1, y, oInvis)) dir *= -1;

if(place_meeting(x, y, oSword)) 
{
	if(oSword.image_alpha == 1)
	{
		with(oPlayer)
		{
			canBlink = true; alarms[4] = infinity;	
		}
		instance_destroy();
	}
}
if(place_meeting(x, y, oProjectile))
{
	var b = instance_nearest(x, y, oProjectile);
	if(b.friendly)
	{
		with(oPlayer)
		{
			canBlink = true; alarms[4] = infinity;	
		}
		instance_destroy();
	}
}