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