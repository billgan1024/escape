/// @description handle state
cameraOffset = smoothApproach(cameraOffset, hsp*100, 0.006);
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
		khsp = approach(khsp, 0, 4*fric);
		updateHsp(walkAcc, walkAcc);
		if(jump || jumpTimer) { vsp = -jumpSpd; state = "jump"; snd(aJump); jumpTimer = false; a[3] = infinity; }
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
			if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); state = "djump"; boosted = false;
			} else {
				vsp = -jumpSpd;	snd(aJump); boosted = false;
				if(a[2] != infinity) a[2] = infinity; else state = "djump";
			}
		}
		if(place_meeting(x, y+1, oGround) && vsp >= 0) { state = "ground"; }
	break;
	case "djump":
		khsp = approach(khsp, 0, fric);
		updateVsp();
		updateHsp(airAcc, airAcc/2); 
		if(jump)
		{
			if(grip != 0) {
				vsp = -jumpSpd;	khsp = wallKickSpd*-grip; snd(aJump); boosted = false;
			} else {
				//jump buffer (like geometry dash)
				jumpTimer = true; a[3] = jumpBuffer;	
			}
		}
		if(place_meeting(x, y+1, oGround) && vsp >= 0) { state = "ground"; }
	break;
}	

//platform code (horizontal)
var p = instance_place(x, y+1, oMovingPlatform); 
if(p != noone) {
	phsp = p.hsp;
} else phsp = 0;


//check collision
hCollision(); vCollision();
clearPressed();