if(!inBoundary()) instance_destroy();
var actualSpd = spd/4;
if(place_meeting(x+lengthdir_x(actualSpd, dir), y+lengthdir_y(actualSpd, dir), oBulletBlocker)) 
{
	//note: lasers should pass through platforms
	while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), oBulletBlocker))
	{
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	instance_destroy();
}

x += lengthdir_x(actualSpd, dir);
y += lengthdir_y(actualSpd, dir);