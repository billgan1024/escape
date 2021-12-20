function vCollision() {
	
	//same method as the platform pick up mechanism: check for all platforms that collide with the 
	//new position of the player while being below the original location of the player
	//find the one that has the lowest y-value (highest) 
	//that is still >= original y+30 closest to the player while 
	
	var targetPlatform = noone, targetY = infinity;
	
	//can fall onto a platform only if ur vsp is >= 0
	//note that place_meeting is inaccurate af for moving platforms, so perform ur own place_meeting check 
	//for rectangle intersection
	var p = noone;
	if(vsp >= 0) {
		for(var i = 0; i < instance_number(oPlatformNew); i++) {
			var p = instance_find(oPlatformNew, i);
			// log(p.y);
			if(!p.deactivated && p.y >= y+30 && y+vsp+30 > p.y && 
				//place_meeting(x, y+vsp, p)
				y+vsp-30 < p.y+30 && x+30 > p.x-120 && x-30 < p.x+120 &&
				//seek out the smallest one
				p.y < targetY) {
				targetPlatform = p; targetY = p.y;
				log(targetPlatform);
			}
		}
	}
	
	//seek out the target platform or the ground
	//if you're going to touch both, seek out the closer one
	//no need to update any state variables
	if(targetPlatform != noone) {
		var g = instance_place(floor(x), floor(y+vsp), oGround);
		if(g != noone) {
			//blocks always have integer coordinates so this is fine
			if(g.bbox_top <= targetPlatform.y) {
				y = g.bbox_top-30; 
			} else y = targetPlatform.y-30;
		} else {
			y = targetPlatform.y-30;
			// log(targetPlatform.y-30);
		}
		vsp = 0;
	} else {

		if(place_meeting(x, y+vsp, oGround)) {
			while(!place_meeting(x, y+sign(vsp), oGround)) y += sign(vsp);
			vsp = 0; vsp_frac = 0;
		}
	}
	y += vsp;	
	
}