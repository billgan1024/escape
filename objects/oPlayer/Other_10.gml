/// @description handle state
cameraOffset = 0; //smoothApproach(cameraOffset, hsp*50, 0.004);
//get input
if(!dead) {
	checkEnemy();
}
if(!dead && canMove) checkInput();

if(input[1][in.shift] && oPersistent.data[?"toggle-sprint"]) toggledSprint = !toggledSprint;

var right = input[0][in.right];
var left = input[0][in.left];
dir = right-left;

jump = input[1][in.up] || input[1][in.space];

jumpHeld = input[0][in.up] || input[0][in.space];
//always toggle dash
down = input[0][in.down];

//update camera speed variable 
cameraSpd = approach(cameraSpd, 5.3*dir, 0.4);

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
		if(input[1][in.enter] && place_meeting(x, y+1, oGround)) {
			freecam = !freecam; snd(freecam ? aCamOn : aCamOff);
		}
		khsp = 0;
		//for running, accelerate slowly if you're trying to speed up to your maximum speed
		//accelerate slightly quicker if you're trying to stop
		updateHsp(runAcc);
		if(jump || preparedJump) { 
			vsp = -jumpSpd; state = "jump"; snd(aJump); canGlide = true;
			event_perform(ev_other, ev_user3); 
		}
		if(!place_meeting(x, y+1, oGround) && !place_meeting(x, y+1, oPlatform)) {
			state = "jump"; a[2] = coyoteTimeBuffer; 
		}
	break;
	case "jump":
		//special check to cancel wallkick speed if you started to move in the other direction and released the key
		checkReleasedWallKick();
		khsp = approach(khsp, 0, fric);
		//if you're trying to dash mid-air, the cost to increase ur speed to maximum speed is greater
		//than the cost to stop
		updateHsp(airAcc); 
		updateVsp();
		if(jump)
		{
			canGlide = true;
			if(grip != 0) wallJump(false); 
			else if(preparedWallJump) wallJump(true);
			else {
				khsp = 0;
				vsp = -jumpSpd; snd(aJump);
				if(a[2] != infinity) a[2] = infinity; else state = "djump";
			}
			event_perform(ev_other, ev_user4);
		}
		if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; canGlide = false; }
	break;
	case "djump":
		if(!dead) smoke(c_gray, 120, -0.005, true, 0.5, x, y);
		checkReleasedWallKick();
		khsp = approach(khsp, 0, fric);
		updateHsp(airAcc); 
		updateVsp();
		if(jump)
		{
			if(grip != 0) { wallJump(false); canGlide = true; }
			else if(preparedWallJump) { wallJump(true); canGlide = true; }
			else {
				//jump buffer (like geometry dash)
				preparedJump = true; a[3] = preparedJumpBuffer;	
			}
		}
		if((place_meeting(x, y+1, oGround) || place_meeting(x, y+1, oPlatform)) && vsp >= 0) { state = "ground"; canGlide = false; }
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
clearInput();