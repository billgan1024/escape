function wallJump(usePrevGrip) {
    vsp = -jumpSpd; 
    var g = usePrevGrip ? prevGrip : grip;
    if(g != infinity) {
	    khsp = wallKickSpd*-g; 
	    
		wallJumpParticles(point_direction(x, y, x+g, y)); wallJumpedThisFrame = true;
    }
    snd(aJump);
	state = "jump"; 
	event_perform(ev_other, ev_user5);
	boosted = false;
}