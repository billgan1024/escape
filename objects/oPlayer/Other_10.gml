/// @description handle state
cameraOffsetX = approach(cameraOffsetX, hsp*50, sign(hsp) == sign(cameraOffsetX) ? 1 : 4);
//get input
if(!dead) {
	checkEnemy();
	if(canInput) checkInput();
}

if(input[1][in.shift] && oPersistent.data[?"toggle-sprint"]) toggledSprint = !toggledSprint;

dirX = input[0][in.right]-input[0][in.left];
dirY = input[0][in.down]-input[0][in.up];

jump = input[1][in.up] || input[1][in.space];
jumpHeld = input[0][in.up] || input[0][in.space];
down = input[0][in.down];

//daily reminder that the player shouldn't be allowed to enter two states at once
//in the same frame
switch(state)
{
	case "ground": 
		//only allow freecam if the player is actually on solid ground and not moving
		//code that always runs in this state
		khsp = 0;	
		updateHsp(runAcc);
		if(input[1][in.enter] && place_meeting(x, y+1, oGround) && hsp == 0) {
			state = "freecam"; 
			//on entering the freecam state, reset the speeds
			snd(aCamOn);
			cameraSpdX = 0; cameraSpdY = 0;
			break;
		}
		if(jump || preparedJump) { 
			vsp = -jumpSpd; state = "jump"; snd(aJump); canGlide = true;
			event_perform(ev_other, ev_user3); 
			break;
		}
	break;
	case "jump":
		//special check to cancel wallkick speed if you started to move in the other direction and released the key
		checkReleasedWallKick();
		khsp = approach(khsp, 0, fric);
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
		}
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
	break;
	case "freecam":
		//free camera movement 
		//update camera speed variable 
		// cameraSpdX = approach(cameraSpdX, 5.3*dirX, 0.4);
		// cameraSpdY = approach(cameraSpdY, 5.3*dirY, 0.4);
		oGame.cameraX += 6*dirX; oGame.cameraY += 6*dirY; 
		//oGame.cameraX = clamp(oGame.cameraX + cameraSpdX, oGame.boundingBox[0], oGame.boundingBox[2]-vw);
		//oGame.cameraY = clamp(oGame.cameraY + cameraSpdY, oGame.boundingBox[1], oGame.boundingBox[3]-vh);
		if(input[1][in.enter]) {
			state = "ground"; snd(aCamOff);
		}
	break;
	case "platform":
		khsp = 0;
		updateHsp(runAcc);
		//vPlatformSpd = pixels moved this frame
		vPlatformSpd = dwave(currentPlatform.ystart-currentPlatform.radius*60,
			currentPlatform.ystart+currentPlatform.radius*60, currentPlatform.period, currentPlatform.t+1/240);
			
		//todo: keep track of any ground you're moving into in both directions
		//and keep track of any platforms you're moving into
		//while in the platform state, the player should only get picked up by other
		//vertical platforms moving upward
		//landingOnPlatform: = true when you're landing on another platform that isn't 
		//the current one
		//var touchingAnotherPlatform = instance_pla
		// var landingOnPlatform = vPlatformSpd >= 0 && (place_meeting(x, y+vPlatformSpd, oPlatform) !== noone) &&  && 
			// !place_meeting(x, y, oPlatform);
		if(place_meeting(x, y+vPlatformSpd, oGround) || landingOnPlatform) {
			//seek out the ground/platform. break ties by going to whichever object is closer
			while(!place_meeting(x, y+sign(vPlatformSpd), oGround) && (landingOnPlatform ? 
				!place_meeting(x, y+sign(vPlatformSpd), oPlatform) : true)) {
					y += sign(vPlatformSpd);
				}
			vPlatformSpd = 0;
		}
		y += vPlatformSpd;
		//-30+wave(currentPlatform.ystart-currentPlatform.radius*60,
			//currentPlatform.ystart+currentPlatform.radius*60, currentPlatform.period, currentPlatform.t+1/240);  
		if(jump || preparedJump) {
			vsp = -jumpSpd+min(0, vPlatformSpd*9/20); state = "jump"; snd(aJump); canGlide = true;
			event_perform(ev_other, ev_user3); 
			break;
		}
	break;
}	


//check collision + update position if the player isn't dead
if(!dead) {
	hCollision(); vCollision();
}

// //check if you're grabbing onto any walls and update grip timer if necessary
// //make sure you can wall jump a short time after leaving the wall, but not after you already performed a wall jump
// //while touching the wall
checkGrip();
wallJumpedThisFrame = false;