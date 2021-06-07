image_angle += 0.75;
t += 1/240;
if(sway) {
	x = wave(xstart-60*radius, xstart+60*radius, period, t*(flip ? -1 : 1));
}
if(place_meeting(x, y, oPlayer)) {
	snd(aCoin);

	light(c_yellow, 0.4);
	var e = part_type_create();
	part_type_sprite(e, sCoin, false, false, false);
	part_type_alpha2(e, 1, 0);
	part_type_speed(e, 3, 3, -0.04, 0);
	part_type_orientation(e, image_angle, image_angle, 1, 0, false);
	part_type_direction(e, 90, 90, 0, false);
	part_type_blend(e, true);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_below, x, y, e, 1);
	instance_destroy();
	with(oDoor) {
		if(fixed) count--;
		else count = instance_number(oCoin); 
	}
}