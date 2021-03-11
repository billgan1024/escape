function ring(col)
{
	var e = part_type_create();
	part_type_shape(e, pt_shape_ring);
	part_type_alpha2(e, 1, 0);
	part_type_colour1(e, col);
	part_type_blend(e, true);
	part_type_size(e, 0.4, 0.4, 0.06, 0);
	part_type_life(e, 40, 40);
	part_particles_create(global.ps_above, x, y, e, 1);
}

function smoke(col)
{
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	part_type_alpha2(e, 1, 0);
	part_type_colour1(e, col);
	part_type_blend(e, true);
	part_type_size(e, 0.5, 0.5, -0.01, 0);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_above, x, y, e, 1);
}

function light(col, xx, yy)
{
	var e = part_type_create();
	part_type_sprite(e, sSphere, 0, 0, 0);
	part_type_colour1(e, col);
	part_type_alpha2(e, 1, 0);
	part_type_size(e, 1, 1, -0.01, 0);
	part_type_blend(e, true);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_above, xx, yy, e, 1);
}

function firework(col) 
{
	repeat(80) {
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_color1(e, col);
		part_type_speed(e, 0.7, 3, -0.026, 0);
		part_type_orientation(e, 0, 360, 1, 0, 0);
		part_type_blend(e, true);
		part_type_size(e, 0.12, 0.14, -0.001, 0);
		part_type_life(e, 180, 200);
		part_type_direction(e, 0, 360, 0, 0);
		part_type_alpha2(e, 1, 0);
		part_particles_create(global.ps_above, x, y, e, 1);
	}
}

function playershrink() {
	var e = part_type_create();
	part_type_sprite(e, sPlayer, 0, 0, 0);
	part_type_size(e, 1, 1, -0.25, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
}