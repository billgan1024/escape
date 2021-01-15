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
function smooth_approach(argument0, argument1, argument2) {
	/*
	 * Example use (smooth camera movement):
	 * view_xview = smooth_approach(view_xview, x-view_wview/2, 0.1);
	 * view_yview = smooth_approach(view_yview, y-view_hview/2, 0.1);
	 */
	var diff = argument1-argument0;
	if abs(diff) < 0.0005
	{
	   return argument1;
	}
	else 
	{
	   return argument0+sign(diff)*abs(diff)*argument2;
	}
}

function check_alarms() {
	for(var i = 1; i <= 15; i++) 
	{
		alarms[i]--;
		if(alarms[i] <= 0) {
			event_perform(ev_other, i+10);
		}
	}
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

