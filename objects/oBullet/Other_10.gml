if(!inBoundary()) instance_destroy();
if(place_meeting(x+lengthdir_x(spd, dir), y+lengthdir_y(spd, dir), oGround)) 
{
	//note: lasers should pass through platforms
	while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), oGround))
	{
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	instance_destroy(id, false);
	firework(c1, c2, 1.5, 5, 80, 100, image_angle+180, 30, 50, 
		x+lengthdir_x(sprite_width*0.42, image_angle), y+lengthdir_y(sprite_height*0.42, image_angle));
	shrink(sBullet);
	light(c2, 1, 1, 0.5, 45);
	
}

x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
