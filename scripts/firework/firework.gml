/// @param col1
/// @param col2
/// @param [lo=0.2]
/// @param [hi=4]
/// @param [lifetime1=140]
/// @param [lifetime2=160]
/// @param [dir=(none)]
/// @param [spread=(everywhere)]
/// @param [count=80]
//default # of particles is 80
function firework(col1, col2, lo, hi, lifetime1, lifetime2, dir, spread, count, xx, yy) {
    //automatically read in col1, col2 as arguments e.g. var col1 = argument[0], col2 = argument[1]
    //if lo and hi are not specified, they are undefined by default 
	repeat(count ?? 80) {
		var spd = random_range(lo ?? 0.2, hi ?? 4), sz = random_range(0.1, 0.2);
		var lifetime = random_range(lifetime1 ?? 140, lifetime2 ?? 160);
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_color2(e, col1, col2);
		part_type_speed(e, spd, spd, -spd/lifetime, 0);
		part_type_orientation(e, 0, 360, 1, 0, 0);
		if(is_undefined(dir)) {
			part_type_direction(e, 0, 360, 0, 0);
		} else {
			part_type_direction(e, dir-spread, dir+spread, 0, 0);
		}
		part_type_size(e, sz, sz, -sz/lifetime, 0);
		part_type_life(e, lifetime, lifetime);
		part_type_blend(e, true);
		part_type_alpha2(e, 1, 0);
		part_particles_create(global.ps_above, xx ?? x, yy ?? y, e, 1);
	}
}