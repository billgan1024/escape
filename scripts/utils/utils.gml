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
/// @param absoluteError (recommended: 0.005)
function smoothApproach(argument0, argument1, argument2, argument3) {
	/*
	 * Example use (smooth camera movement):
	 * view_xview = smooth_approach(view_xview, x-view_wview/2, 0.1);
	 * view_yview = smooth_approach(view_yview, y-view_hview/2, 0.1);
	 */
	var diff = argument1-argument0;
	if abs(diff) < argument3
	{
	   return argument1;
	}
	else 
	{
	   return argument0+sign(diff)*abs(diff)*argument2;
	}
}

function update() {
	for(var i = 1; i <= 15; i++) 
	{
		a[i]--;
		if(a[i] <= 0) {
			event_perform(ev_other, i+10);
		}
	}
	event_perform(ev_other, ev_user0);
}

/// @param from
/// @param to
/// @param duration
/// @param offset
/// @param parameter
function wave(argument0, argument1, argument2, argument3, argument4) {

	var arg4 = (argument1 - argument0) * 0.5;
	return argument0 + arg4 + sin(((argument4 + argument2 * argument3) / argument2) * (pi*2)) * arg4;
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

function collision() {
	
	if(place_meeting(x+hsp+khsp, y, oGround))
	{
		while(!place_meeting(x+sign(hsp+khsp), y, oGround)) x += sign(hsp+khsp);
		hsp = 0; khsp = 0;
	}
	x += hsp+khsp;
	if(place_meeting(x, y+vsp+kvsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp+kvsp), oGround)) y += sign(vsp+kvsp);
		vsp = 0; kvsp = 0;
	}
	y += vsp+kvsp;	
}

function inView()
{
	return bbox_right > vx
	&& bbox_left < vx+vw
	&& bbox_bottom > vy
	&& bbox_top < vy+vh;
}

function array()
{
	var arr;
	for(var i = 0; i < argument_count; i++) arr[i] = argument[i];
	return arr;
}

