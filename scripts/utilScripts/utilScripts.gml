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
/// @param [error=1]
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

//returns an array c[3] 
//c[0] = FIRST instance which collides with this laser (noone if it doesn't exist)
//c[1], c[2] = points of collision
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param object
/// @param precise
/// @param notme
function lightCollision(x1, y1, x2, y2, qi, qp, qn)
{
	rr = collision_line(x1, y1, x2, y2, qi, qp, qn);
	rx = x2;
	ry = y2;
	if (rr != noone) {
	    var _p0 = 0;
	    var _p1 = 1;
	    repeat (ceil(log2(point_distance(x1, y1, x2, y2))) + 1) {
	        var np = _p0 + (_p1 - _p0) * 0.5;
	        var nx = x1 + (x2 - x1) * np;
	        var ny = y1 + (y2 - y1) * np;
	        var px = x1 + (x2 - x1) * _p0;
	        var py = y1 + (y2 - y1) * _p0;
	        var nr = collision_line(px, py, nx, ny, qi, qp, qn);
	        if (nr != noone) {
	            rr = nr;
	            rx = nx;
	            ry = ny;
	            _p1 = np;
	        } else _p0 = np;
	    }
	}
	var r;
	r[0] = rr;
	r[1] = rx;
	r[2] = ry;
	return r;
}

function draw_rectangle_width(x1, y1, x2, y2, w, a)
{
	if(w == 0) return;
	draw_sprite_ext(sWhite, 0, x1, y1, w, y2-y1+1, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x2-w+1, y1, w, y2-y1+1, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x1+w, y1, x2-x1-2*w+1, w, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x1+w, y2-w+1, x2-x1-2*w+1, w, 0, c_white, a);
	
	/*draw_rectangle(x1, y1, x1+w, y2, false);
	draw_rectangle(x2-w, y1, x2, y2, false);
	draw_rectangle(x1+(w+1), y1, x2-(w+1), y1+w, false);
	draw_rectangle(x1+(w+1), y2-w, x2-(w+1), y2, false);*/
}

function mouseOver(x1, y1, x2, y2) {
	return mouse_x >= x1 && mouse_x <= x2 && mouse_y >= y1 && mouse_y <= y2;
}