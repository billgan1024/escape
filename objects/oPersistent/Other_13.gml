/// @description star particles
var e = part_type_create();
part_type_shape(e, pt_shape_sphere);
part_type_colour1(e, c_white);
if(room == menu) part_type_speed(e, 11/4, 12/4, 0, 0);
else part_type_speed(e, 11, 12, 0, 0);
part_type_direction(e, 0, 0, 0, 0)
part_type_size(e, 0.12, 0.16, 0, 0);
part_type_life(e, 4800, 4800);
part_type_alpha1(e, random_range(0.5, 0.6));
part_type_orientation(e, 0, 359, 0.05, 0, false);
part_particles_create(global.ps_below, 0, random(room_height), e, 1);
if(room == menu) a[3] += random_range(60, 360);
else a[3] += random_range(30, 40);