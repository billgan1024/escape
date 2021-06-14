function light(col, size)
{
	var e = part_type_create();
	part_type_sprite(e, sSphere, false, false, false);
	part_type_colour1(e, col);
	part_type_alpha2(e, 1, 0);
	part_type_size(e, size, size, 0, 0);
	part_type_blend(e, true);
	part_type_life(e, 50, 50);
	part_particles_create(global.ps_below, x, y, e, 1);
}

/// @param col1
/// @param col2
/// @param [small]
/// @param [large]
function firework() {
	var col1 = argument0, col2 = argument1;
	var lo = 0.2, hi = 4;
	if(argument_count >= 4) { lo = argument2; hi = argument3; }
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

function shrink(spr) {
	var e = part_type_create();
	
	part_type_sprite(e, spr, 0, 0, 0);
	part_type_size(e, 1, 1, -0.07, 0);
	part_particles_create(global.ps_above, x, y, e, 1);
}

function smoke(col, life, decrease, below, alpha) {
	var e = part_type_create();
	part_type_shape(e, pt_shape_smoke);
	part_type_alpha2(e, alpha, 0);
	part_type_colour1(e, col);
	part_type_size(e, 0.3, 0.3, decrease, 0);
	part_type_blend(e, true);
	part_type_life(e, 60, 60);
	if(below) part_particles_create(global.ps_below, x, y, e, 1); 
	else part_particles_create(global.ps_above, x, y, e, 1); 
}	

function wallJumpParticles(g) {
	var dir = point_direction(x, y, x+g, y);
	var spread = random_range(20, 25);
	for(var i = 0; i < 3; i++) {
		var e = part_type_create();
	    part_type_shape(e, pt_shape_smoke);
	    part_type_size(e, 0.3, 0.3, -0.005, 0);
	    part_type_alpha2(e, 1, 0);
	    part_type_direction(e, dir-spread+spread*i, dir-spread+spread*i, 0, 0);
	    part_type_speed(e, 2, 2, -0.01, 0);
	    part_type_orientation(e, 0, 359, 1, 0, false);
	    part_particles_create(global.ps_above, x, y, e, 1);
	}
}

function bgParticles() {
	for(var i = 0; i < room_height/vh; i++) {
		var e = part_type_create();
		part_type_shape(e, pt_shape_sphere);
		part_type_colour1(e, c_white);
		part_type_direction(e, 0, 0, 0, 0);
		part_type_life(e, 4800, 4800);
		part_type_speed(e, 2.5, 3.5, 0, 0);
		part_type_alpha1(e, random_range(0.2, 0.3));
		part_type_size(e, 0.14, 0.18, 0, 0);
		part_type_orientation(e, 0, 359, 0.05, 0, false);
		part_particles_create(global.ps_bg, 0, i*vh+random(room_height), e, 1);
	}
}