function bgParticles() {
	for(var i = 0; i < room_height/vh; i++) {
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_colour1(e, c_white);
		part_type_direction(e, 0, 0, 0, 0);
		part_type_life(e, 4800, 4800);
		part_type_speed(e, 2.5, 3.5, 0, 0);
		part_type_alpha1(e, random_range(0.2, 0.3));
		part_type_size(e, 0.14, 0.18, 0, 0);
		part_type_orientation(e, 0, 359, 0.05, 0, false);
		part_particles_create(global.ps_bg, 0, i*vh+random(room_height), e, 1);
	}
}