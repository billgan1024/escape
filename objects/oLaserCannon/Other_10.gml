image_angle += rspd; t += 1/240;
laserWidth = wave(9, 12, 0.15, 0, t); 
c = laser_collision(x, y, x+lengthdir_x(2560, image_angle), y+lengthdir_y(2560, image_angle), oGround, false, true);
//if the player is within the collision line, commit vaporize
if(cannonState == 2)
{
	if(collision_line(x, y, c[1], c[2], oPlayer, false, true))
	{
		with(oPlayer)
		{
			if(state != "blink") death();
		}
	}
}