/// @description gem particles
if(state == 0) {
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	var sz = random_range(1.5, 1.6);
	part_type_size(e, sz/5.7, sz/5.7, -0.003, 0);
	part_type_color2(e, c_white, c_orange);
	part_type_speed(e, sz, sz, -0.01, 0);
	part_type_life(e, sz/0.018, sz/0.018);
	part_type_direction(e, 0, 360, 0, 0);
	part_type_alpha2(e, 1, 0);
	part_particles_create(global.ps_below, x, y, e, 1);
}

a[1] = random_range(15, 60);