t += 1/240; image_angle += 1;
//y = wave(ystart-10, ystart+10, 1.5, 0, t);
if(place_meeting(x, y, oPlayer)) {
	audio_play_sound(aCoin, 0, false);
	
	var e1 = part_type_create();
	part_type_sprite(e1, sSphere, false, false, false);
	part_type_colour1(e1, c_yellow);
	part_type_alpha2(e1, 1, 0);
	part_type_size(e1, 0.5, 0.5, 0, 0);
	part_type_life(e1, 100, 100);
	part_type_blend(e1, true);
	part_particles_create(global.ps_below, x, y, e1, 1);
	
	var e = part_type_create();
	part_type_sprite(e, sCoin, false, false, false);
	part_type_alpha2(e, 1, 0);
	part_type_speed(e, 4, 4, -0.1, 0);
	part_type_orientation(e, image_angle, image_angle, 1, 0, false);
	part_type_direction(e, 90, 90, 0, false);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_below, x, y, e, 1);
	instance_destroy();
}