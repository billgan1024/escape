if(cannonState == 2)
{
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	var sz = random_range(2.5, 3.5);
	part_type_size(e, sz/10, sz/10, -0.004, 0);
	part_type_color1(e, c_white);
	part_type_speed(e, sz, sz, -0.04, 0);
	part_type_life(e, sz/0.04, sz/0.04);
	part_type_direction(e, image_angle-180-45, image_angle-180+45, 0, 0);
	part_type_alpha2(e, 1, 0);
	part_particles_create(global.ps_below, c[1], c[2], e, 1);	
}

alarms[2] = random_range(4, 5);