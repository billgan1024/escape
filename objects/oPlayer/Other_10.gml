/// @description handle state
//get input
if(!dead) {
	
	//actual # of pixels to move last frame (a real value)
	// hsp += hsp_frac; 
	// vsp += vsp_frac;
	
	cameraOffsetX = approach(cameraOffsetX, hsp*50, sign(hsp) == sign(cameraOffsetX) ? 1 : 4);
	checkEnemy();
	if(canInput) checkInput();
	
	
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
			khsp = 0;	
			updateHsp(runAcc);
			if(input[1][in.enter] && place_meeting(x, y+1, oGround) && hsp == 0) {
				state = "freecam"; 
				//on entering the freecam state, reset the speeds
				snd(aCamOn);
				cameraSpdX = 0; cameraSpdY = 0;
				break;
			}
			//on an actual jump off the ground or a platform, prepare to jump
			//scale this by platform vertical speed
			if(jump || preparedJump) { 
				vsp = -jumpSpd + (platform != noone ? min(platform.vsp/2, 0) : 0); state = "jump"; snd(aJump); canGlide = true; platform = noone;
				event_perform(ev_other, ev_user3); 
				break;
			}
		break;
		case "jump":
			//special check to cancel wallkick speed if you started to move in the other direction and released the key
			// if(!dead) smoke(c_gray, 120, -0.005, true, 0.5, particleX, particleY);
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
			// if(!dead) smoke(c_gray, 120, -0.005, true, 0.5, particleX, particleY);
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
	}	
	
	
	//check collision + update position if the player isn't dead
	//edit: we need to make sure the player is on integer coordinates for better collision
	//this basically stores your spare dx each time so that you only move an integer number of pixels each time.
	//note that you must keep setting hsp (i.e. the current # of pixels to move) for this to work properly.
	
	//good spot here
	//now hsp and vsp represent the number of pixels to move this time
	// hsp_frac = hsp+khsp - round(hsp+khsp); //frac(hsp);
	// vsp_frac = vsp - round(vsp); //frac(vsp);
	// hsp -= hsp_frac;
	// vsp -= vsp_frac;
	
	// show_debug_message(vsp_frac);
	// show_debug_message("rounded vsp: " + string(vsp) + "actual vsp: " + string(vsp+vsp_frac));
	hCollision(); vCollision();
	// particleX = x+hsp_frac; particleY = y+vsp_frac;
	
	// //check if you're grabbing onto any walls and update grip timer if necessary
	// //make sure you can wall jump a short time after leaving the wall, but not after you already performed a wall jump
	// //while touching the wall
	checkGrip();
	wallJumpedThisFrame = false;
	
	//after everything, change state
	changeState();
}
clearInput();