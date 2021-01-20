var e = part_type_create();
part_type_shape(e, pt_shape_square);
part_type_colour1(e, make_color_rgb(16, 107, 163));//make_color_rgb(125,81,37));
part_type_speed(e, 5, 6, 0, 0);
part_type_direction(e, 0, 0, 0, 0)
part_type_size(e, 0.15, 0.2, 0, 0);
part_type_life(e, 4800, 4800);
part_type_orientation(e, 0, 359, 0.05, 0, false);
part_particles_create(global.ps_below, 0, random(room_height), e, 1);
alarms[1] += random_range(20, 30);