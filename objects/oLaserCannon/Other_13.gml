/// @description particles
if(state == 1) {
    var e = part_type_create();
    part_type_shape(e, pt_shape_smoke);
    part_type_size(e, 0.2, 0.4, -0.008, 0);
    part_type_alpha2(e, 1, 0);
    part_type_direction(e, image_angle+180-30, image_angle+180+30, 0, 0);
    part_type_speed(e, 4.5, 5, -0.01, 0);
    part_particles_create(global.ps_below, c[1], c[2], e, 1);
}
a[3] += 8;