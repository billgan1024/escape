//note: because belowlight is in layer below,
//the laser lights will still be drawn at the below layer
//even if you're iterating through every missile cannon
with(oMissileCannon) draw_sprite_general(sLaserLight, 
	0, 0, 0, len, 15, 
	x+lengthdir_x(15/2, image_angle+90), 
	y+lengthdir_y(15/2, image_angle+90), 
	1, 1, image_angle, c_white, c_white, c_white, 
	c_white, laserAlpha);

with(oLaserCannon) {
	if(state == 1) {
		draw_sprite_ext(sLaser, 0, x, y, len, laserWidth, image_angle, c_white, 1); 
	}
}

with(oLaserCannon) {
	if(state == 0) draw_sprite_ext(sLaserLight2, 0, x, y, len, 0.06, image_angle, c_white, 0.4);
}
gpu_set_blendmode(bm_add);
with(oLaserCannon) {
	if(state == 1) {
		draw_sprite_ext(sLaserLightCircle, 0, x, y, 1, 1, image_angle, c_purple, 0.4);
		draw_sprite_ext(sLaserLight2, 0, x, y, len, 1, image_angle, c_purple, 0.4);
		draw_sprite_ext(sLaserLightCircle, 0, c[1], c[2], 1, 1, image_angle+180, c_purple, 0.4);
		draw_sprite_ext(sLaserBurst, 0, c[1], c[2], laserBurstSize, laserBurstSize, 0, c_white, 1);
	}
}
gpu_set_blendmode(bm_normal);

