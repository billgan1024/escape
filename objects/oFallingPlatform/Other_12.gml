/// @description disappear
state = 2;
var e = part_type_create();
part_type_sprite(e, sPlatform, 0, 0, 0);
part_type_alpha2(e, 1, 0);
part_type_speed(e, 5, 5, -0.08, 0);
part_type_direction(e, 270, 270, 0, 0);
part_type_life(e, 60, 60);
part_particles_create(global.ps_below, x, y, e, 1);
deactivated = true; image_alpha = 0;
a[2] = infinity;