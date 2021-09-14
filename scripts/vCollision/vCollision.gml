function vCollision() {
	//platforms are only going to have a hitbox if the player is on top of them so 
	//you don't need to check whether vsp >= 0
	//todo: make platforms have a constant mask and make the player get moved by them automatically
	//so that enemies can also use platforms
	
	//check if you're about to land on a platform; if you are, then incorporate the platform
	//into the vertical collision check
	
	
	//todo: get rid of platform state since that's completely useless
	//only keep track of the current platform and their current 
	var landingOnPlatform = vsp >= 0 && place_meeting(x, y+vsp, oPlatform) && 
		!place_meeting(x, y, oPlatform);
	if(place_meeting(x, y+vsp, oGround) || landingOnPlatform) {
		//seek out the ground/platform. break ties by going to whichever object is closer
		while(!place_meeting(x, y+sign(vsp), oGround) && (landingOnPlatform ? 
			!place_meeting(x, y+sign(vsp), oPlatform) : true)) {
				y += sign(vsp);
			}
		vsp = 0;
	}
	y += vsp;	
}