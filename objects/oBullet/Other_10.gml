if(!inBoundary()) instance_destroy();
if(place_meeting(x+lengthdir_x(spd, dir), y+lengthdir_y(spd, dir), oBulletBlocker)) 
{
	//note: lasers should pass through platforms
	while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), oBulletBlocker))
	{
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	instance_destroy(id, false);
}

x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);