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
	return wave(from, to, period, t)-wave(from, to, period, t-1/240);
}

/// @param current
/// @param  target
/// @param  turn_speed
function angleApproach(argument0, argument1, argument2) {
	/*
	 * Example use (rotate to face towards the cursor):
	 * var target_angle = point_direction(x, y, mouse_x, mouse_y);
	 * image_angle = angle_approach(image_angle, target_angle, 4);
	 */
	var tempdir;
	var angle = argument0;
	var target_angle = argument1;
	var turn_speed = argument2;
	var diff = abs(target_angle-angle);
	if (diff > 180)
	{
	    if (target_angle > 180)
	    {
	        tempdir = target_angle - 360;
	        if (abs(tempdir-angle ) > turn_speed)
	        {
	            angle -= turn_speed;
	        }
	        else
	        {
	            angle = target_angle;
	        }
	    }
	    else
	    {
	        tempdir = target_angle + 360;
	        if (abs(tempdir-angle) > turn_speed)
	        {
	            angle += turn_speed;
	        }
	        else
	        {
	            angle = target_angle;
	        }
	    }
	}
	else
	{
	    if (diff > turn_speed)
	    {
	        if (target_angle > angle)
	        {
	            angle += turn_speed;
	        }
	        else
	        {
	            angle -= turn_speed;
	        }
	    }
	    else
	    {
	        angle = target_angle;
	    }
	}
	return angle;
}

/// @param offset
function inView(offset)
{
	return bbox_right > vx-offset
	&& bbox_left < vx+vw+offset
	&& bbox_bottom > vy-offset
	&& bbox_top < vy+vh+offset;
}

function array()
{
	var arr;
	for(var i = 0; i < argument_count; i++) arr[i] = argument[i];
	return arr;
}