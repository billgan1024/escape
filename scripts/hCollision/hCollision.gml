function hCollision() {
	var tsp = hsp+khsp;
	if(place_meeting(x+tsp, y, oGround))
	{
		while(!place_meeting(x+sign(tsp), y, oGround)) x += sign(tsp);
		hsp = 0; khsp = 0; hsp_frac = 0;
	}
	x += hsp+khsp; 
}