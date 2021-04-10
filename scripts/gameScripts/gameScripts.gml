function checkEnemy() {
	if(y-30 >= room_height) death(aSplat);
	if(place_meeting(x, y, oEnemyParent)) death(aExplosion);
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

/// @param checkError
function vCollision(checkError) {
	if(place_meeting(x, y+vsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp), oGround)) y += sign(vsp);
		//anti-jumperror check 
		if(checkError && vsp < 0)
		{
			var b = instance_place(x, y-1, oGround);
			if(x >= b.bbox_right+30-jumpError) x = b.bbox_right+31;
			else if(x <= b.bbox_left-30+jumpError) x = b.bbox_left-31;
			else vsp = 0;
		} else vsp = 0;
	}
	y += vsp;	
}
/// @param walkAcc
/// @param runAcc
function updateHsp(walkAcc, runAcc) {
	if(dash) hsp = approach(hsp, dir*(runSpd-abs(khsp)*11/12), runAcc); 
	else hsp = approach(hsp, dir*(walkSpd-abs(khsp)*11/12), walkAcc);
}

function updateVsp() {
	//apply more grav if player isn't holding jump
	if(!boosted && !jumpHeld && vsp < 0) vsp += grav*2;
	if(grip != 0 && vsp > 0)
	{ 
		if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*2); 
		else vsp = approach(vsp, maxGrav/3, grav/3); 
	}
	else if(vsp > 0 && down) vsp = smoothApproach(vsp, maxGrav*9/8, 0.025);
	else vsp = approach(vsp, maxGrav, grav);
}

function death(audio) {
	snd(audio); dead = true; image_alpha = 0;
	firework(c_white, c_white);
	shrink(sPlayer);
	oGame.shake = 10;
	oGame.targetLvl = oGame.lvl;
	oGame.a[1] = 120;
}

/// @param pathIndex
/// @param pathSpeed [0-1]
/// @param loop
function path(p, pathSpd, loop) {
	path_start(p, 0, path_action_stop, true);
	spd = pathSpd; rev = !loop;
}

function resetArea() {
	with(oEnemy) { x = xstart; y = ystart; hsp = hspStart; }
	with(oSpike) { 
		path_position = 0; image_angle = 0; 
		image_angle = 0; path_position = startPos; }
	with(oCoin) { image_angle = 0; x = xstart; t = 0; }
	with(oMovingPlatform) { t = 0; }
	with(oFallingPlatform) { state = 0; }
	with(oBullet) instance_destroy();
	with(oBulletCannon) {
		a[3] = delayStart;
		a[2] = infinity;
	}
}