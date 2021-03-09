//laser stuff
var xx = lengthdir_x(12, image_angle);
var yy = lengthdir_y(12, image_angle);
var dx = c[1]+xx-x, dy = c[2]+yy-y;
if(cannonState == 2)
{
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sLaserLightBase, 0, x+lengthdir_x(46-50, image_angle), y+lengthdir_y(46-50, image_angle), 3.125, 3.125, image_angle, c_purple, 0.6);
	draw_sprite_ext(sLaserLight, 0, x+lengthdir_x(46, image_angle), y+lengthdir_y(46, image_angle), sqrt(dx*dx + dy*dy), 4, image_angle, c_purple, 0.6);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(sLaser, 0, x, y, sqrt(dx*dx + dy*dy), laserWidth/12, image_angle, c_white, 1);
	var sz = random_range(1, 1.5);
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sLaserBurst, 0, c[1], c[2], sz, sz, 1, c_white, 1);
	gpu_set_blendmode(bm_normal);
	//effect_create_below(ef_firework, c[1], c[2], 0, c_white);
	//draw_line_width_color(x, y, c[1]+xx, c[2]+yy, laserWidth, c_red, c_red);
} else if(cannonState == 1)
{
	draw_sprite_ext(sLaserLight, 0, x, y, sqrt(dx*dx + dy*dy), 0.5, image_angle, c_white, 0.3);
}
draw_self();