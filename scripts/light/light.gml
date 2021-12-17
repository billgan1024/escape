/// @param col
/// @param size 
/// @param xscale 
/// @param yscale 
/// @param [life=50]
function light(col, size, xscale, yscale, life)
{
	var e = part_type_create();
	part_type_sprite(e, sSphere, false, false, false);
	part_type_scale(e, xscale ?? 1, yscale ?? 1);
	part_type_colour1(e, col);
	part_type_alpha2(e, 1, 0);
	part_type_size(e, size, size, 0, 0);
	part_type_orientation(e, image_angle, image_angle, 0, 0, 0);
	part_type_blend(e, true);
	part_type_life(e, life ?? 50, life ?? 50);
	part_particles_create(global.ps_below, x, y, e, 1);
}