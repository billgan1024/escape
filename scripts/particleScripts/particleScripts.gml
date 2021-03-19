//each particle script should be configured with sz as a parameter
//so that particles won't look that similar

function light(col, xx, yy)
{
	var e = part_type_create();
	part_type_sprite(e, sSphere, 0, 0, 0);
	part_type_colour1(e, col);
	part_type_alpha2(e, 1, 0);
	part_type_size(e, 1, 1, -0.01, 0);
	part_type_life(e, 60, 60);
	part_particles_create(global.ps_above, xx, yy, e, 1);
}

function firework() 
{
	var col = argument[0], col2 = -1;
	if(argument_count == 2) col2 = argument[1];
	repeat(80) {
		var spd = random_range(0.2, 4), sz = random_range(0.1, 0.2);
		var lifetime = random_range(140, 160);
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		if(col2 != -1) part_type_color2(e, col, col2);
		else part_type_color1(e, col);
		part_type_speed(e, spd, spd, -spd/lifetime, 0);
		part_type_orientation(e, 0, 360, 1, 0, 0);
		part_type_size(e, sz, sz, -sz/lifetime, 0);
		part_type_life(e, lifetime, lifetime);
		part_type_direction(e, 0, 360, 0, 0);
		part_type_alpha2(e, 1, 0);
		part_particles_create(global.ps_above, x, y, e, 1);
	}
}

function shrink(spr) {
	var e = part_type_create();
	part_type_sprite(e, spr, 0, 0, 0);
	part_type_size(e, 1, 1, -0.1, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
}