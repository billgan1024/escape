function hCollision() {
	var tsp = hsp+khsp+phsp;
	if(place_meeting(x+tsp, y, oGround))
	{
		while(!place_meeting(x+sign(tsp), y, oGround)) x += sign(tsp);
		hsp = 0; khsp = 0; phsp = 0;
	}
	x += hsp+khsp+phsp; 
}