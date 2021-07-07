function smoke(col, life, decrease, below, alpha, xx, yy) {
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	part_type_alpha2(e, alpha, 0);
	part_type_colour1(e, col);
	part_type_size(e, 0.3, 0.3, decrease, 0);
	part_type_blend(e, true);
	part_type_life(e, 60, 60);
	if(below) part_particles_create(global.ps_below, xx, yy, e, 1); 
	else part_particles_create(global.ps_above, xx, yy, e, 1); 
}	