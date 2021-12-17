function bgParticles() {
	var sz = room == menu ? [0.16, 0.2] : [0.14, 0.18];
	var ap = room == menu ? [0.2, 0.3] : [0.2, 0.25];
	var spd = room == menu ? [3, 3.5] : [6, 6.5];
	for(var i = 0; i < room_height/vh; i++) {
		var shift = random(vh);
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_colour1(e, c_white);
		part_type_direction(e, 0, 0, 0, 0);
		part_type_life(e, 4800, 4800);
		part_type_speed(e, spd[0], spd[1], 0, 0);
		part_type_alpha1(e, random_range(ap[0], ap[1]));
		part_type_size(e, sz[0], sz[1], 0, 0);
		part_type_orientation(e, 0, 359, 0.05, 0, false);
		part_particles_create(global.ps_bg, 0, i*vh+shift, e, 1);
	}
}