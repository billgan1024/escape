with(oMissileCannon) draw_sprite_general(sLaserLight, 
	0, 0, 0, len, 15, 
	x+lengthdir_x(15/2, image_angle+90), 
	y+lengthdir_y(15/2, image_angle+90), 
	1, 1, image_angle, c_white, c_white, c_white, 
	c_white, laserAlpha);