function changeState() {
	//check if player moved off the platform 
	//when you jump off a platform, we already update the player's state to disengage from the platform
    if(state == "ground") {
        //check if you left the ground and the platform
		if(!place_meeting(x, y+1, oGround) && (platform == noone ? true : 
		//!place_meeting(x, y+1, platform)
		!(y == platform.y-30 && x+30 > platform.x-120 && x-30 < platform.x+120))) {
			state = "jump"; a[2] = coyoteTimeBuffer; platform = noone;
		}
		//assuming ur not on a platform, if u left it, update the thing.
		if(platform != noone && !(y == platform.y-30 && x+30 > platform.x-120 && x-30 < platform.x+120)) {
			platform = noone;	
		}
    } else if(state == "jump" || state == "djump") {
        //you're in mid-air, so check if you touched the ground 
        //note that place meeting for y+1, oGround doesn't need the vsp >= 0 check since
        //there's no way to enter the ground from below
        //that's why there's a vsp check for oPlatform
        // var g = instance_place(x, y+1, oPlatform), h = instance_place(x, y, oPlatform);
        if(place_meeting(x, y+1, oGround)) { 
            state = "ground"; canGlide = false; a[2] = infinity; vsp = 0; vsp_frac = 0;
        } 
        // if(vsp >= 0 && g != noone && h == noone) {
        // 	canGlide = false;
        // 	//current version: make the player
        // 	if(g.object_index == oHorizontalPlatform) {
        // 		state = "ground"; 
        // 	} else {
        // 		state = "platform"; currentPlatform = g; y = g.y-30;
        // 	}
        // }
    }
}