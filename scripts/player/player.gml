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

function applyGrav() {
	if((place_meeting(x+1, y, oGround) || place_meeting(x-1, y, oGround)) && vsp >= 0) 
		vsp = approach(vsp, maxGrav/3, grav/3);
	else vsp = approach(vsp, maxGrav, grav);	
}