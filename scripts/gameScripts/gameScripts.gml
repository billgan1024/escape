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
		phsp = p.hsp;
	} else phsp = 0;
	var q = instance_place(x, y+1, oFallingPlatform);
	if(q != noone && q.state == 0) { snd(aPlatform); q.state = 1; q.a[2] = 240; }
}
/// @param walkAcc
/// @param runAcc
function updateHsp(walkAcc, runAcc) {
	if(dash) hsp = approach(hsp, dir*(runSpd-abs(khsp)*11/12), runAcc); 
	else {
		hsp = approach(hsp, dir*(walkSpd-abs(khsp)*11/12), walkAcc);
	}
}

function updateVsp() {
	//apply more grav if player isn't holding jump
	if(!boosted && !jumpHeld && vsp < 0) vsp += grav*1.5;
	if(grip != 0 && vsp > 0)
	{ 
		if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*4); 
		else vsp = approach(vsp, maxGrav/3, grav/3); 
	}
	else if(vsp > 0 && down) vsp = smoothApproach(vsp, maxGrav*9/8, 0.027);
	else vsp = approach(vsp, maxGrav, grav);
}

function checkReleasedWallKick() {
	if(khsp > 0 && hsp+khsp < 0 && input3[in.left]) khsp /= 2;
	if(khsp < 0 && hsp+khsp > 0 && input3[in.right]) khsp /= 2;
}

function checkGrip() {
	if(place_meeting(x+1, y, oGround)) grip = 1;
	else if(place_meeting(x-1, y, oGround)) grip = -1;
	else grip = 0;
	
	if(grip != gripLastFrame && grip == 0) {
		//update grip timer and grip direction last frame
		gripTimer = true; gripDirLastFrame = gripLastFrame; a[5] = gripBuffer; 
	}
	gripLastFrame = grip;
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
	}
}

/// @param pathIndex
/// @param pathSpeed [0-1]
/// @param loop
/// @param [pathPos=0]
/// @param [absolute=true]
function path(p, pathSpd, loop) {
	spd = pathSpd; rev = !loop; var absolute = true;
	if(argument_count >= 4) { path_position = argument3; startPos = path_position; }
	if(argument_count >= 5) absolute = argument4;
	path_start(p, 0, path_action_stop, absolute);
}

function setRotate(pathSpd, pathPoint) {
	originX = path_get_point_x(pathPoint, 0);  
	originY = path_get_point_y(pathPoint, 0); 
	radialSpd = pathSpd;
}

function resetArea() {
	with(oEnemy) { x = xstart; y = ystart; hsp = hspStart; }
	with(oSpike) { 
		path_position = 0; image_angle = 0; 
		image_angle = 0; path_position = startPos; t = 0; }
	with(oCoin) { image_angle = 0; x = xstart; t = 0; a[1] = random_range(90, 120); }
	with(oMovingPlatform) { t = 0; }
	with(oFallingPlatform) { state = 0; a[1] = random_range(40, 60); a[2] = infinity; }
	with(oBullet) instance_destroy();
	with(oMissile) instance_destroy();
	with(oBulletCannon) { a[1] = delayStart; a[2] = infinity; }
	with(oMissileCannon) { a[1] = delayStart; a[2] = infinity; image_angle = angleStart; }
	with(oGem) { t = 0; a[1] = random_range(15, 60); }
	with(oGemOrange) { state = 0; t = 0; a[1] = random_range(15, 60); }
}

/// @param hspStart
/// @param [gravDir=1]
function setEnemy() {
	if(argument_count == 2) { gravDir = argument1; gravDirStart = gravDir; }
	hsp = argument0; hspStart = argument0;	
}

/// @param startDelay
/// @param actualDelay
/// @param bulletSpd
function setCannon() {
	a[1] = argument0; delayStart = argument0;
	delay = argument1; bulletSpd = argument2;
	if(object_index == oMissileCannon) angleStart = image_angle;
}

/// @param radius
/// @param period
/// @param [flip=false]
function setWave() {
	if(object_index == oCoin) sway = true;
	radius = argument0; period = argument1;
	if(argument_count == 3) flip = argument2;
}

//returns an array c[3] 
//c[0] = FIRST instance which collides with this laser (noone if it doesn't exist)
//c[1], c[2] = points of collision
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param object
/// @param precise
/// @param notme
function lightCollision(x1, y1, x2, y2, qi, qp, qn)
{
	rr = collision_line(x1, y1, x2, y2, qi, qp, qn);
	rx = x2;
	ry = y2;
	if (rr != noone) {
	    var _p0 = 0;
	    var _p1 = 1;
	    repeat (ceil(log2(point_distance(x1, y1, x2, y2))) + 1) {
	        var np = _p0 + (_p1 - _p0) * 0.5;
	        var nx = x1 + (x2 - x1) * np;
	        var ny = y1 + (y2 - y1) * np;
	        var px = x1 + (x2 - x1) * _p0;
	        var py = y1 + (y2 - y1) * _p0;
	        var nr = collision_line(px, py, nx, ny, qi, qp, qn);
	        if (nr != noone) {
	            rr = nr;
	            rx = nx;
	            ry = ny;
	            _p1 = np;
	        } else _p0 = np;
	    }
	}
	var r;
	r[0] = rr;
	r[1] = rx;
	r[2] = ry;
	return r;
}