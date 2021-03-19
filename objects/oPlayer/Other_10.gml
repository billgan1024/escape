/// @description handle state
cameraOffset = smoothApproach(cameraOffset, hsp*100, 0.008);
//get input
checkInput();
//check for all hazards
checkEnemy();

var right = input[in.right] || input[in.keyD];
var left = input[in.left] || input[in.keyA];
dir = right-left;
jump = input2[in.up] || input2[in.keyW] || input2[in.space];
jumpHeld = input[in.up] || input[in.keyW] || input[in.space];
dash = input[in.shift];
down = input[in.down] || input[in.keyS];

//check if you're grabbing onto any walls
if(place_meeting(x+1, y, oGround)) grip = 1;
else if(place_meeting(x-1, y, oGround)) grip = -1;
else grip = 0;

cameraOffset = smoothApproach(cameraOffset, hsp*100, 0.008);
switch(state)
{
	case "ground": 
		boosted = false;
		khsp = approach(khsp, 0, 3*fric);
		updateHsp(walkAcc, walkAcc);
		if(jump) { vsp = -jumpSpd; state = "jump"; snd(aJump); }
		if(!place_meeting(x, y+1, oGround)) {
			state = "jump"; a[2] = bufferTime;	
		}
	break;
	case "jump":
		khsp = approach(khsp, 0, fric);
		updateHsp(airAcc, airAcc/2); 
		updateVsp();
		if(jump)
		{
			if(place_meeting(x, y+jumpPixels, oGround)) {	
				vsp = -jumpSpd;	snd(aJump); boosted = false;
			} else if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); state = "djump"; boosted = false;
			} else {
				vsp = -jumpSpd;	snd(aJump); boosted = false;
				if(a[2] != infinity) a[2] = infinity; else state = "djump";
			}
		}
		if(place_meeting(x, y+1, oGround)) { state = "ground"; }
	break;
	case "djump":
		khsp = approach(khsp, 0, fric);
		updateVsp();
		updateHsp(airAcc, airAcc/2); 
		if(jump)
		{
			if(place_meeting(x, y+jumpPixels, oGround)) {	
				vsp = -jumpSpd;	snd(aJump); boosted = false; state = "jump";
			} else if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); boosted = false;
			}
		}
		if(place_meeting(x, y+1, oGround)) { state = "ground"; }
	break;
}
//check collision
collision();
clearPressed();