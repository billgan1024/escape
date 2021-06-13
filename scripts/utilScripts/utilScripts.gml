/// @param arr
/// @param elem
function find(arr, elem) {
	for(var i = 0; i < array_length(arr); i++) {
		if(arr[i] == elem) return i;
	}
	return -1;
}

/// @param from
/// @param to
/// @param amnt [absolute value]
function approach(argument0, argument1, argument2) {
	if (argument0 < argument1)
	{
	    argument0 += argument2;
	    if (argument0 > argument1)
	        return argument1;
	}
	else
	{
	    argument0 -= argument2;
	    if (argument0 < argument1)
	        return argument1;
	}
	return argument0;
}

/// @param from
/// @param to
/// @param amnt [0-1]
/// @param [error]
function smoothApproach() {
	var error = 1;
	if(argument_count == 4) error = argument3;
	var diff = argument1-argument0;
	if abs(diff) < error
	{
	   return argument1;
	}
	else 
	{
	   return argument0+sign(diff)*abs(diff)*argument2;
	}
}

function update() {
	if(variable_instance_exists(id, "a"))
	{
		for(var i = 1; i <= 15; i++) 
		{
			a[i]--;
			if(a[i] <= 0) {
				event_perform(ev_other, i+10);
			}
		}
	}
	event_perform(ev_other, ev_user0);
}

/// @param from
/// @param to
/// @param period
/// @param parameter
function wave(from, to, period, t) {
	return (to-from)/2*sin(2*pi/period*t) + (from+to)/2;
}

//dx/dt for wave
/// @param from
/// @param to
/// @param period
/// @param parameter
function dwave(from, to, period, t) {
	return wave(from, to, period, t+1/240)-wave(from, to, period, t);
}

/// @param current
/// @param target
/// @param turnSpd
function angleApproach(current, target, turnSpd) {
	//we assume that all angles are in [0, 360) and the angle returned will also be in [0, 360)
	var d = angle_difference(current, target), angle1 = (current-turnSpd+360)%360, angle2 = (current+turnSpd)%360;
	if(abs(d) <= turnSpd) return target;
	else {
		if(abs(angle_difference(angle1, target)) < abs(angle_difference(angle2, target))) return angle1;
		else return angle2;
	}
}

function inView()
{
	return x >= vx && x <= vx+vw && y >= vy && y <= vy+vh;
}

function inBoundary() {
	return x >= oGame.leftBoundary-sprite_width/2-60 && x <= oGame.rightBoundary+vw+sprite_width/2+60 
	&& y >= oGame.yLevel*vh-sprite_height/2-60 && y <= oGame.yLevel*vh+vh+sprite_height/2+60; 
}

//remember that arrays are passed by reference but if ur changing this array
//it gets copied
function arraySort(array, ascend)
{
    var list = ds_list_create();
    var count = array_length(array);
    for (var i=0; i<count; i++) list[| i] = array[i];
    ds_list_sort(list, ascend);
    for (i=0; i<count; i++) array[i] = list[| i];
    ds_list_destroy(list);
    return array;
}

function drawHitbox() {
	draw_line(bbox_left, bbox_top, bbox_right, bbox_top);
	draw_line(bbox_left, bbox_top, bbox_left, bbox_bottom);
	draw_line(bbox_right, bbox_top, bbox_right, bbox_bottom);
	draw_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom);
}

function log() {
	var str = "";
	for(var i = 0; i < argument_count; i++) {
		str += string(argument[i]) + " ";	
	}
	show_debug_message(str);
}