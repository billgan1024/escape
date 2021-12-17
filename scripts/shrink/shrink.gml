function shrink(spr) {
	var e = part_type_create();
	
	part_type_sprite(e, spr, 0, 0, 0);
	part_type_orientation(e, image_angle, image_angle, 0, 0, 0);
	part_type_size(e, 1, 1, -0.07, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
}