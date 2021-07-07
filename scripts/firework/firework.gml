/// @param col1
/// @param col2
/// @param [lo=0.2]
/// @param [hi=4]
function firework(col1, col2, lo, hi) {
    //automatically read in col1, col2 as arguments e.g. var col1 = argument[0], col2 = argument[1]
    //if lo and hi are not specified, they are undefined by default 
    if(is_undefined(lo)) lo = 0.2; if(is_undefined(hi)) hi = 4;
	repeat(80) {
		var spd = random_range(lo, hi), sz = random_range(0.1, 0.2);
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