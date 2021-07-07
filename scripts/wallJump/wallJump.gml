function wallJump(usePrevGrip) {
    vsp = -jumpSpd; khsp = wallKickSpd*-(usePrevGrip ? prevGrip : grip); snd(aJump);
	wallJumpParticles(point_direction(x, y, x+(usePrevGrip ? prevGrip : grip), y)); wallJumpedThisFrame = true;
	state = "jump"; 
	event_perform(ev_other, ev_user5);
	boosted = false;
}