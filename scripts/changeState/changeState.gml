function changeState() {
    if(state == "ground") {
        //check if you left the ground 
        //in this state, you can't get picked up by platforms
		if(!place_meeting(x, y+1, oGround) && !place_meeting(x, y+1, oPlatform)) {
			state = "jump"; a[2] = coyoteTimeBuffer; 
		}
    } else if(state == "platform") {
    	//leaving the platform will apply some velocity in wherever you're going
    	if(!(place_meeting(x, y+1, oPlatform) && !place_meeting(x, y, oPlatform))) {
			state = "jump"; a[2] = coyoteTimeBuffer; 
			vsp = vPlatformSpd <= 0 ? vPlatformSpd/3 : vPlatformSpd*3/4;
    	}
    } else if(state == "jump" || state == "djump") {
        //you're in mid-air, so check if you touched the ground 
        //note that place meeting for y+1, oGround doesn't need the vsp >= 0 check since
        //there's no way to enter the ground from below
        //that's why there's a vsp check for oPlatform
        var g = instance_place(x, y+1, oPlatform), h = instance_place(x, y, oPlatform);
        if(place_meeting(x, y+1, oGround)) { 
            state = "ground"; canGlide = false; 
        } 
        if(vsp >= 0 && g != noone && h == noone) {
        	canGlide = false;
        	//current version: make the player
        	if(g.object_index == oHorizontalPlatform) {
        		state = "ground"; 
        	} else {
        		state = "platform"; currentPlatform = g; y = g.y-30;
        	}
        }
    }
}