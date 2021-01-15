function ring(col)
{
	var e = part_type_create();
	part_type_shape(e, pt_shape_ring);
	part_type_alpha2(e, 1, 0);
	part_type_colour1(e, col);
	part_type_size(e, 0.5, 0.5, 0.1, 0);
	part_type_life(e, 30, 30);
	part_particles_create(global.ps_above, x, y, e, 1);
}

function smoke(col)
{
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	part_type_alpha2(e, 1, 0);
	part_type_colour1(e, col);
	part_type_size(e, 0.5, 0.5, -0.01, 0);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_above, x, y, e, 1);
}