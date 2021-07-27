function updateVsp() {
	if(vsp < 0) {
		if(!jumpHeld) vsp += grav*2;
		else vsp += grav;
	} else {
		if(grip != 0) {
			if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*4); 
			else vsp = approach(vsp, maxGrav/3, grav/3); 
		} else if(down) {
			vsp = smoothApproach(vsp, maxGrav*9/8, 0.026);
		} else if(jumpHeld && canGlide) {
			if(vsp > maxGrav/2) vsp = approach(vsp, maxGrav/2, grav*4); 
			else vsp = approach(vsp, maxGrav/2, grav*2/5); 
		} else {
			if(vsp > maxGrav) vsp = approach(vsp, maxGrav, grav*4);
			else vsp = approach(vsp, maxGrav, grav); 
		}
	}
}