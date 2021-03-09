t += 1/240;
image_angle += rspd;
//image_angle = wave(225, 315, 3, 0, t);
laserWidth = wave(14, 18, 0.2, 0, t); 
c = laser_collision(x, y, x+lengthdir_x(2560, image_angle), y+lengthdir_y(2560, image_angle), oGround, false, true);
//if the player is within the collision line, commit vaporize
if(cannonState == 2)
{
	if(!instance_exists(oPlayer)) return;
	if(!collision_line(x, y, oPlayer.x, oPlayer.y, oGround, true, true))
	{
		//line equation: ax+by+c = 0
		
		var dx = c[1]-x, dy = c[2]-y;
		var d = abs(dx*(y-oPlayer.y) - dy*(x-oPlayer.x))/sqrt(dx*dx + dy*dy);
		if(d <= 32)
		{
			if(abs(angle_difference(point_direction(x, y, oPlayer.x, oPlayer.y), image_angle)) <= 90) { with(oPlayer) death(); }
		}
	}
}