function checkEnemy() {
	if(y-30 >= room_height) death(aSplat);
	if(place_meeting(x, y, oEnemyParent)) {
		death(aExplosion);
		with(instance_place(x, y, oEnemyParent)) {
			if(object_index == oMissile) {
				instance_destroy();
				snd(aExplosion2);
				firework(c_orange, c_orange, 0.1, 2);
			}
		}
	}
}

function hCollision() {
	var tsp = hsp+khsp+phsp;
	if(place_meeting(x+tsp, y, oGround))
	{
		while(!place_meeting(x+sign(tsp), y, oGround)) x += sign(tsp);
		hsp = 0; khsp = 0; phsp = 0;
	}
	x += hsp+khsp+phsp; 
}

function vCollision() {
	if(place_meeting(x, y+vsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp), oGround)) y += sign(vsp);
		vsp = 0;
	}
	if(place_meeting(x, y+vsp, oPlatform))
	{
		while(!place_meeting(x, y+sign(vsp), oPlatform)) y += sign(vsp);
		vsp = 0;
	}
	y += vsp;	
}

function pCollision() {
	var p = instance_place(x, y+1, oMovingPlatform); 
	if(p != noone) {
		phsp = p.hsp; //log(x-p.x);
	} else phsp = 0;
	var q = instance_place(x, y+1, oFallingPlatform);
	if(q != noone && q.state == 0) { snd(aPlatform); q.state = 1; q.a[2] = 210; }
}

function updateHsp(walkAcc, runAcc) {
	if(dash) hsp = approach(hsp, dir*(runSpd-abs(khsp)*11/12), runAcc); 
	else {
		hsp = approach(hsp, dir*(walkSpd-abs(khsp)*11/12), walkAcc);
	}
}

function updateVsp() {
	if(vsp < 0) {
		if(!jumpHeld) vsp += grav*2;
		else vsp += grav;
	} else {
		if(grip != 0) {
			if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*4); 
			else vsp = approach(vsp, maxGrav/3, grav/3); 
		} else if(down) {
			vsp = smoothApproach(vsp, maxGrav*9/8, 0.026);
		} else if(jumpHeld) {
			if(vsp > maxGrav/2) vsp = approach(vsp, maxGrav/2, grav*4); 
			else vsp = approach(vsp, maxGrav/2, grav*2/5); 
		} else {
			if(vsp > maxGrav) vsp = approach(vsp, maxGrav, grav*4);
			else vsp = approach(vsp, maxGrav, grav); 
		}
	}
}

function checkReleasedWallKick() {
	if(khsp > 0 && hsp+khsp < wallKickSpd/2 && input[2][in.left]) khsp /= 2;
	if(khsp < 0 && hsp+khsp > -wallKickSpd/2 && input[2][in.right]) khsp /= 2;
}

function checkGrip() {
	//grip = -1, 0, 1 depending on whether the player is touching a side wall for delayed 
	//walljump time
	//first, check if the grip buffer should be set to false prematurely 
	//this is when you let go of the movement key
	if(input[2][in.right] && gripDirLastFrame == -1) { gripTimer = false; a[5] = infinity; }
	if(input[2][in.left] && gripDirLastFrame == 1) { gripTimer = false; a[5] = infinity; }
	if(sign(hsp+khsp) == sign(gripDirLastFrame)) { gripTimer = false; a[5] = infinity; }
	if(place_meeting(x+1, y, oGround)) grip = 1;
	else if(place_meeting(x-1, y, oGround)) grip = -1;
	else grip = 0;
	
	if(!wallJumpedThisFrame && grip != gripLastFrame && grip == 0) {
		//update grip timer and grip direction last frame
		gripTimer = true; gripDirLastFrame = gripLastFrame; a[5] = gripBuffer; 
	}
	gripLastFrame = grip;
}

function wallJump(usePrevFrame) {
    vsp = -jumpSpd*(dash ? 9/10 : 1); khsp = wallKickSpd*-(usePrevFrame ? gripDirLastFrame : grip); snd(aJump);
	wallJumpParticles(grip); wallJumpedThisFrame = true;
	state = "jump"; 
	event_perform(ev_other, ev_user5);
	boosted = false;
}

function death(audio) {
	snd(audio); dead = true; image_alpha = 0;
	firework(c_white, c_white);
	shrink(sPlayer);
	oGame.shake = 10;
	//only reset the level if u haven't collected the gem yet
	if(oGame.a[1] == infinity) {
		oGame.targetLvl = oGame.lvl;
		oGame.a[1] = 120;
		var body = {
			level: oGame.lvl,
			xpos: x,
			ypos: y
		}
		with(oPersistent) {
			if(transmitData) post = http_request("https://escape-server-1024.herokuapp.com/deaths/add", "POST", headerMap, json_stringify(body));
		}
	}
}
