t += 1/240; //image_angle += 0.75;
y = wave(ystart-8, ystart+8, 1.5, 0, t);
if(place_meeting(x, y, oPlayer)) {
	//oGame.shake = 8;
	audio_play_sound(aGem, 0, false);
	
	var e1 = part_type_create();
	part_type_sprite(e1, sSphere, false, false, false);
	part_type_colour1(e1, c_green);
	part_type_alpha2(e1, 1, 0);
	part_type_size(e1, 1, 1, 0, 0);
	part_type_life(e1, 100, 100);
	part_type_blend(e1, true);
	part_particles_create(global.ps_below, x, y, e1, 1);
	firework(c_white, c_green);
	var e = part_type_create();
	part_type_sprite(e, sGem, 0, 0, 0);
	part_type_size(e, 1, 1, -0.05, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
	instance_destroy();
}