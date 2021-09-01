function changeState() {
    if(state == "ground") {
        //check if you left the ground 
		if(!place_meeting(x, y+1, oGround) && !place_meeting(x, y+1, oPlatform)) {
			state = "jump"; a[2] = coyoteTimeBuffer; 
		}
    } else if(state == "jump" || state == "djump") {
        //you're in mid-air, so check if you touch the ground 
        if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { 
            state = "ground"; canGlide = false; 
        } 
    }
}