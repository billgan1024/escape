//the enemy parent also functions as a layer of spikes
for(var i = 0; i < image_xscale; i++) {
	draw_sprite_ext(sSpikes, 0, x+lengthdir_x(60*i, image_angle), y+lengthdir_y(60*i, image_angle), 1, 1, image_angle, c_white, 1);
}