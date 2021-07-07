function wallJumpParticles(dir) {
	var spread = random_range(20, 25);
	for(var i = 0; i < 3; i++) {
		var e = part_type_create();
	    part_type_shape(e, pt_shape_smoke);
	    part_type_size(e, 0.3, 0.3, -0.005, 0);
	    part_type_alpha2(e, 1, 0);
	    part_type_direction(e, dir-spread+spread*i, dir-spread+spread*i, 0, 0);
	    part_type_speed(e, 2, 2, -0.01, 0);
	    part_type_orientation(e, 0, 359, 1, 0, false);
	    part_particles_create(global.ps_above, x, y, e, 1);
	}
}