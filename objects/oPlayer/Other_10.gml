/// @description handle state
cameraOffset = smoothApproach(cameraOffset, hsp*100, 0.006);
//get input
if(!dead) {
	if(canMove) checkInput();
	checkEnemy();
}

var right = input[in.right] || input[in.keyD];
var left = input[in.left] || input[in.keyA];
dir = right-left;

jump = input2[in.up] || input2[in.keyW] || input2[in.space];

jumpHeld = input[in.up] || input[in.keyW] || input[in.space];
dash = input[in.shift];
down = input[in.down] || input[in.keyS];

//if we're in freecam mode, cancel all inputs and only care about dir
//to control the game's camera
if(freecam) {
	oGame.targetX = clamp(oGame.targetX + 6*dir, oGame.leftBoundary, oGame.rightBoundary);
	dir = 0; jump = false; jumpHeld = false; dash = false; down = false;
}

//check if you're grabbing onto any walls
if(place_meeting(x+1, y, oGround)) grip = 1;
else if(place_meeting(x-1, y, oGround)) grip = -1;
else grip = 0;

cameraOffset = smoothApproach(cameraOffset, hsp*100, 0.008);
switch(state)
{
	case "ground": 
		//only allow freecam if the player is grounded
		if(input2[in.enter]) {
			freecam = !freecam;
			if(freecam) snd(aCamOn);
			else snd(aCamOff);
		}
		boosted = false;
		khsp = approach(khsp, 0, 4*fric);
		updateHsp(walkAcc, walkAcc);
		if(jump || jumpTimer) { 
			vsp = -jumpSpd; state = "jump"; snd(aJump); 
			event_perform(ev_other, ev_user3); 
			
		}
		if(!place_meeting(x, y+1, oGround)) {
			state = "jump"; a[2] = bufferTime;	
		}
	break;
	case "jump":
		khsp = approach(khsp, 0, fric);
		updateHsp(airAcc, airAcc/2); 
		updateVsp();
		if(jump || boostTimer)
		{
			if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); state = "djump"; boosted = false;
			} else {
				vsp = -jumpSpd;	snd(aJump); boosted = false;
				if(a[2] != infinity) a[2] = infinity; else state = "djump";
			}
			event_perform(ev_other, ev_user4);
		}
		if(place_meeting(x, y+1, oGround) && vsp >= 0) { state = "ground"; }
	break;
	case "djump":
		khsp = approach(khsp, 0, fric);
		updateVsp();
		updateHsp(airAcc, airAcc/2); 
		if(jump || boostTimer)
		{
			if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); boosted = false;
			} else {
				//jump buffer (like geometry dash)
				jumpTimer = true; a[3] = jumpBuffer;	
			}
			event_perform(ev_other, ev_user4);
		}
		if(place_meeting(x, y+1, oGround) && vsp >= 0) { state = "ground"; }
	break;
	case "boosted":
	//boosted state for when you hit a jump powerup
	//you can't jump until you reach a certain vsp threshold (i.e. when you aren't moving as quick anymore)
		khsp = approach(khsp, 0, fric);
		updateVsp();
		updateHsp(airAcc, airAcc/2); 
		if(jump) {
			boostTimer = true; a[4] = jumpBuffer;
		}
		//renew the jump i guess
		if(vsp >= -jumpSpd) { state = "jump"; }
	break;
}	
if(vsp >= 0)
{
	var p = instance_place(x, y+1, oMovingPlatform); 
	if(p != noone) {
		phsp = p.hsp;
	} else phsp = 0;
	var q = instance_place(x, y+1, oFallingPlatform);
	if(q != noone && q.state == 0) { snd(aPlatform); q.state = 1; q.a[2] = 120; }
} else phsp = 0;

//check collision
if(!dead) {
	hCollision(); vCollision();
}
clearPressed();