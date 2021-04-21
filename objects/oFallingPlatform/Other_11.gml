/// @description hover particles
if(state != 2) {
	var e = part_type_create();
	part_type_color1(e, make_colour_rgb(32, 34, 37));
	part_type_shape(e, pt_shape_square);
	part_type_size(e, 0.28, 0.32, -0.002, 0);
	part_type_speed(e, 2, 2.2, -0.005, 0);
	part_type_direction(e, 270, 270, 0, 0);
	part_type_orientation(e, 0, 360, random_range(-3, 3), 0, 0);
	part_type_alpha2(e, 1, 0);
	part_particles_create(global.ps_below, random_range(x-100, x+100), y+10, e, 1);
}
a[1] += random_range(40, 60);
