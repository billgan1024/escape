//note: because belowlight is in layer below,
//the laser lights will still be drawn at the below layer
//even if you're iterating through every missile cannon
with(oMissileCannon) draw_sprite_general(sLaserLight, 
	0, 0, 0, len, 15, 
	x+lengthdir_x(15/2, image_angle+90), 
	y+lengthdir_y(15/2, image_angle+90), 
	1, 1, image_angle, c_white, c_white, c_white, 
	c_white, laserAlpha);