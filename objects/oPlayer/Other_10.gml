/// @description handle state
cameraOffset = 0; //smoothApproach(cameraOffset, hsp*50, 0.004);
//get input
if(!dead) {
	checkEnemy();
}
if(!dead && canMove) checkInput();

var right = input[in.right];
var left = input[in.left];
dir = right-left;

jump = input2[in.up] || input2[in.space];

jumpHeld = input[in.up] || input[in.space];
dash = input[in.shift] || toggleSprint;
down = input[in.down];

//update camera speed variable 
cameraSpd = approach(cameraSpd, 5.5*dir, 0.4);

//if we're in freecam mode, cancel all inputs and move the camera
if(freecam) {
	
	oGame.targetX = clamp(oGame.targetX + cameraSpd, oGame.leftBoundary, oGame.rightBoundary);
	
	//free camera movement 
	//oGame.targetX += 6*dir; oGame.targetY += 6*(input[in.down]-input[in.up]);
	
	dir = 0; jump = false; jumpHeld = false; dash = false; down = false;
}


switch(state)
{
	case "ground": 
		//only allow freecam if the player is actually on solid ground
		if(input2[in.enter] && place_meeting(x, y+1, oGround)) {
			freecam = !freecam; snd(freecam ? aCamOn : aCamOff);
		}
		khsp = 0;
		updateHsp(walkAcc, walkAcc/8);
		if(jump || preparedJump) { 
			vsp = -jumpSpd; state = "jump"; snd(aJump); 
			event_perform(ev_other, ev_user3); 
		}
		if(!place_meeting(x, y+1, oGround) && !place_meeting(x, y+1, oPlatform)) {
			state = "jump"; a[2] = bufferTime;	
		}
	break;
	case "jump":
		//special check to cancel wallkick speed if you started to move in the other direction and released the key
		checkReleasedWallKick();
		khsp = approach(khsp, 0, fric);
		updateHsp(airAcc, airAcc/2); 
		updateVsp();
		if(jump)
		{
			if(grip != 0) wallJump(false);
			else if(gripTimer) wallJump(true);
			else {
				khsp = 0;
				vsp = -jumpSpd;	snd(aJump);
				if(a[2] != infinity) a[2] = infinity; else state = "djump";
			}
			event_perform(ev_other, ev_user4);
		}
		if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; }
	break;
	case "djump":
		if(!dead) smoke(c_gray, 120, -0.005, true, 0.5);
		checkReleasedWallKick();
		khsp = approach(khsp, 0, fric);
		updateVsp();
		updateHsp(airAcc, airAcc/2); 
		if(jump)
		{
			if(grip != 0) wallJump(false);
			else if(gripTimer) wallJump(true);
			else {
				//jump buffer (like geometry dash)
				preparedJump = true; a[3] = jumpBuffer;	
			}
		}
		if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; }
	break;
}	

//falling platform check
if(vsp >= 0) pCollision(); else phsp = 0;

//check collision
if(!dead) {
	hCollision(); vCollision();
}

//check if you're grabbing onto any walls and update grip timer if necessary
//make sure you can wall jump a short time after leaving the wall, but not after you already performed a wall jump
//while touching the wall
checkGrip();
wallJumpedThisFrame = false;
clearPressed(); clearReleased();