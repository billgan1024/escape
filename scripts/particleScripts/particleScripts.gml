//each particle script should be configured with sz as a parameter
//so that particles won't look that similar

function light(col, size)
{
	var e = part_type_create();
	part_type_sprite(e, sSphere, false, false, false);
	part_type_colour1(e, col);
	part_type_alpha2(e, 1, 0);
	part_type_size(e, size, size, 0, 0);
	part_type_blend(e, true);
	part_type_life(e, 50, 50);
	part_particles_create(global.ps_below, x, y, e, 1);
}

function firework(col1, col2) 
{
	repeat(80) {
		var spd = random_range(0.2, 4), sz = random_range(0.1, 0.2);
		var lifetime = random_range(140, 160);
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_color2(e, col1, col2);
		part_type_speed(e, spd, spd, -spd/lifetime, 0);
		part_type_orientation(e, 0, 360, 1, 0, 0);
		part_type_size(e, sz, sz, -sz/lifetime, 0);
		part_type_life(e, lifetime, lifetime);
		part_type_blend(e, true);
		part_type_direction(e, 0, 360, 0, 0);
		part_type_alpha2(e, 1, 0);
		part_particles_create(global.ps_above, x, y, e, 1);
	}
}

function shrink(spr) {
	var e = part_type_create();
	part_type_sprite(e, spr, 0, 0, 0);
	part_type_size(e, 1, 1, -0.08, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
}