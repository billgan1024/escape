function checkGrip() {
	//grip = -1, 0, 1 depending on whether the player is touching a side wall for delayed 
	//walljump time
	//first, check if the grip buffer should be set to false prematurely 
	//this is when you let go of the movement key
	if(input[2][in.right] && prevGrip == -1) { preparedWallJump = false; a[5] = infinity; }
	if(input[2][in.left] && prevGrip == 1) { preparedWallJump = false; a[5] = infinity; }
	if(sign(hsp+khsp) == sign(prevGrip)) { preparedWallJump = false; a[5] = infinity; }
	var r = place_meeting(x+1, y, oGround), l = place_meeting(x-1, y, oGround);
	if(r && l) grip = infinity;
	else if(r) grip = 1;
	else if(l) grip = -1;
	else grip = 0;
	
	if(!wallJumpedThisFrame && grip != gripLastFrame && grip == 0) {
		//update grip timer and grip direction last frame
		//note: we don't update the grip
		preparedWallJump = true; prevGrip = gripLastFrame; a[5] = preparedWallJumpBuffer; 
	}
	gripLastFrame = grip;
}