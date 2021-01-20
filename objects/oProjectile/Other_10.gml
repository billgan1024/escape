if(place_meeting(x+lengthdir_x(speed, direction), y+lengthdir_y(speed, direction), oGround)) 
{
	while(!place_meeting(x+lengthdir_x(1, direction), y+lengthdir_y(1, direction), oGround))
	{
		x += lengthdir_x(1, direction);
		y += lengthdir_y(1, direction);
	}
	var xx = x+lengthdir_x(sprite_width/2, image_angle);
	var yy = y+lengthdir_y(sprite_height/2, image_angle)
	instance_destroy();
	ring(colour);
	//effect_create_above(ef_firework, xx, yy, 0, colour);
}