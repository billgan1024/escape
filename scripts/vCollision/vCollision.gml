function vCollision() {
	if(place_meeting(x, y+vsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp), oGround)) y += sign(vsp);
		vsp = 0;
	}
	if(place_meeting(x, y+vsp, oPlatform))
	{
		while(!place_meeting(x, y+sign(vsp), oPlatform)) y += sign(vsp);
		vsp = 0;
	}
	y += vsp;	
	//transition to a new state (only used for player)
	if(object_index == oPlayer) {
		switch(state) {
			case "ground":
				if(!place_meeting(x, y+1, oGround) && !place_meeting(x, y+1, oPlatform)) {
					state = "jump"; a[2] = coyoteTimeBuffer; 
					break;
				}
			break;
			case "jump":
				if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; canGlide = false; }
			break;
			case "djump":
				if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; canGlide = false; }
			break;
		}
	}
}