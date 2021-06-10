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
		phsp = p.hsp; log(x-p.x);
	} else phsp = 0;
	var q = instance_place(x, y+1, oFallingPlatform);
	if(q != noone && q.state == 0) { snd(aPlatform); q.state = 1; q.a[2] = 210; }
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
	if(khsp > 0 && hsp+khsp < wallKickSpd/2 && input3[in.left]) khsp /= 2;
	if(khsp < 0 && hsp+khsp > -wallKickSpd/2 && input3[in.right]) khsp /= 2;
}

function checkGrip() {
	//grip = -1, 0, 1 depending on whether the player is touching a side wall for delayed 
	//walljump time
	//first, check if the grip buffer should be set to false prematurely 
	//this is when you let go of the movement key
	if(input3[in.right] && gripDirLastFrame == -1) { gripTimer = false; a[5] = infinity; }
	if(input3[in.left] && gripDirLastFrame == 1) { gripTimer = false; a[5] = infinity; }
	if(sign(hsp+khsp) == sign(gripDirLastFrame)) { gripTimer = false; a[5] = infinity; }
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

function getRotateSpd(s) {
	return 1 + abs(s)/4;
}

/// @param pathIndex
/// @param pathSpeed [0-1]
/// @param loop
/// @param [pos=0]
/// @param [offsetX=default]
/// @param [offsetY=default]
function path(_pathIdx, _spd, _loop) {
	//in this new implementation, the spikes are always put in relative mode
	//if an hpath/vpath is selected, the new path will be created and destroyed on cleanup
	//if you specify hpath/vpath as the path, only put 
	pathIdx = _pathIdx;
	spd = _spd/4; rotateSpd = getRotateSpd(spd); loop = _loop; 
	if(argument_count >= 4) { pos = argument3; startPos = pos; }
	offsetX = x-path_get_x(pathIdx, startPos); offsetY = y-path_get_y(pathIdx, startPos);
	if(argument_count >= 6) { offsetX = argument4; offsetY = argument5; }
}

function open(_x, _y) {
	return instance_place(_x, _y, oGround) == noone &&
	instance_place(_x, _y, oEnemyBlocker) == noone;
}

//constructs a single point at the starting position as a path.
function point() {
	customPath = true;
	pathIdx = path_add(); path_add_point(pathIdx, x, y, 100);
}

/// @param spd
function hpath(_spd) {
	//automatically constructs a path and updates the necessary path data for this spike
	//spd can be positive or negative. (+) means you're moving to the right, (-) means you're
	//returning from the left.
	customPath = true;
	pathIdx = path_add(); var x1 = x, x2 = x;
	while(x1 > lb && open(x1, y)) x1 -= 30;
	while(x2 < rb && open(x2, y)) x2 += 30;
	x1 += 30; x2 -= 30;
	path_add_point(pathIdx, x1, y, 100); path_add_point(pathIdx, x2, y, 100);
	path_set_closed(pathIdx, false);
	path_set_kind(pathIdx, 0);
	spd = _spd/4; rotateSpd = getRotateSpd(spd); pos = (x-x1)/(x2-x1); startPos = pos;
}

/// @param spd
function vpath(_spd) {
	//automatically constructs a path and updates the necessary path data for this spike
	//spd can be positive or negative. (+) means you're moving to the right, (-) means you're
	//returning from the left.
	customPath = true;
	pathIdx = path_add(); var y1 = y, y2 = y;
	while(y1 > top && open(x, y1)) y1 -= 30;
	while(y2 < top+vh && open(x, y2)) y2 += 30;
	y1 += 30; y2 -= 30;
	path_add_point(pathIdx, x, y1, 100); path_add_point(pathIdx, x, y2, 100);
	path_set_closed(pathIdx, false);
	path_set_kind(pathIdx, 0);
	spd = _spd/4; rotateSpd = getRotateSpd(spd); pos = (y-y1)/(y2-y1); startPos = pos;
	log(pos);
}

//take the current path of the user and apply it to a group of spikes
//with the option of applying circular speed and a starting angle
//remember to set a path first before calling this function
function generateSpikes(l, r, circularSpd, startingAngle, radial) {
	var _pathIdx = pathIdx, _spd = spd, _loop = loop, _pos = pos, ox = offsetX, oy = offsetY, 
	for(var i = l; i <= r; i++) {
		with(instance_create_layer(x + lengthdir_x(60*i, startingAngle), y + lengthdir_y(60*i, startingAngle), "Enemies", oSpike)) {
			pathIdx = _pathIdx; spd = _spd; loop = _loop;
			angle = startingAngle; offsetX = ox; offsetY = oy; startAngle = startingAngle;
			radius = 60*i; pos = _pos; startPos = pos;
			if(radial) {
				angularSpd = circularSpd; 
				rotateSpd = getRotateSpd(degtorad(circularSpd)*radius);
			} else {
				//remember to divide pathSpd by 4
				angularSpd = radtodeg((circularSpd/4)/radius);
				rotateSpd = getRotateSpd(circularSpd/4);
			}
		}
	}
	//deactivate this spike
	image_alpha = 0; mask_index = sNone;
}

function resetArea() {
	with(oEnemy) { x = xstart; y = ystart; hsp = hspStart; }
	with(oSpike) { 
		image_angle = 0; pos = startPos; angle = startAngle;
		x = path_get_x(pathIdx, pos) + lengthdir_x(radius, angle) + offsetX;
		y = path_get_y(pathIdx, pos) + lengthdir_y(radius, angle) + offsetY;
	}
	with(oCoin) { image_angle = 0; x = xstart; t = 0; a[1] = random_range(90, 120); }
	with(oMovingPlatform) { t = 0; }
	with(oFallingPlatform) { state = 0; a[1] = random_range(40, 60); a[2] = infinity; }
	instance_destroy(oBullet);
	instance_destroy(oMissile, false);	
	with(oBulletCannon) { a[1] = delayStart; a[2] = infinity; }
	with(oMissileCannon) { 
		a[1] = delayStart; a[2] = infinity; image_angle = angleStart; 
		len = 0; laserAlpha = 0;
	}
	with(oLaserCannon) {
		state = 0; a[1] = delayStart; a[2] = infinity; t = 0; len = 0; a[3] = 8;
		image_angle = angleStart;
	}
	with(oGem) { t = 0; a[1] = random_range(15, 60); }
	with(oGemOrange) { state = 0; t = 0; a[1] = random_range(15, 60); }
}

/// @param hsp
/// @param [gravDir=1]
function setEnemy(_hsp) {
	if(argument_count == 2) { gravDir = argument1; gravDirStart = gravDir; }
	hsp = _hsp/4; hspStart = hsp; 
}

/// @param delayStart 
/// @param delay
/// @param bulletSpd
function setCannon(_delayStart, _delay, _bulletSpd) {
	a[1] = _delayStart; delayStart = _delayStart;
	delay = _delay; bulletSpd = _bulletSpd/4;
	if(object_index == oMissileCannon) angleStart = image_angle;
}

//for laser cannons 
//set laser interval + speed
/// @param delayStart
/// @param delayActive
/// @param delayRest
/// @param [angularSpd = 0]
function setLaserInterval(_delayStart, _delayActive, _delayRest) {
	var _angularSpd = 0; if(argument_count == 4) angularSpd = argument3;
	a[1] = _delayStart; delayStart = _delayStart;
	delayActive = _delayActive; delayRest = _delayRest; angleStart = image_angle;
	angularSpd = _angularSpd;
}

/// @param radius
/// @param period
/// @param [flip=false]
function setWave() {
	//note: setWave can also be used to set laser cannon stuff
	if(object_index == oCoin || object_index == oLaserCannon) sway = true;
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

//for testing purposes only, since this function takes a lot of time to execute
function createLevel(img) {
	var w = sprite_get_width(img); // image width
	var h = sprite_get_height(img); // image height
	var surf = surface_create(w, h); // create a surface

	surface_set_target(surf); // set the surface target
	draw_sprite(img, 0, 0, 0); // draw the image to the surface
	surface_reset_target(); // reset the surface target
	for (var i = 0; i < w; i++) { // cycle through width of image
    	for (var j = 0; j < h; j++) { // cycle through height of image
	        // get the pixel color at the given coordinates (SLOW FUNCTION, use graciously)
	        var col = surface_getpixel(surf, i, j);
	        var boundary = make_colour_rgb(0, 104, 171), ground = make_colour_rgb(22, 24, 26);
	        var player = make_colour_rgb(34, 197, 94);
			var platform = make_colour_rgb(107, 114, 128);
			var tmp = make_colour_rgb(249, 115, 22);
	        if(col == boundary) {
	        	instance_create_layer(60*i, 60*j, "Persistent", oBoundary);
	        	instance_create_layer(60*i, 60*j, "Ground", oGround);
	        }
	        else if(col == ground) instance_create_layer(60*i, 60*j, "Ground", oGround);
	        else if(col == player) instance_create_layer(60*i, 60*j, "Player", oPlayer);
	        else if(col == platform) instance_create_layer(60*i, 60*j, "Ground", oFallingPlatform);
	        else if(col == tmp) {
	        	for(var k = 0; k < 360; k += 90) {
	        		with(instance_create_layer(60*i, 60*j, "Enemies", oBulletCannon)) {
	        			image_angle = k;
	        			setCannon(120, 480, 18);
	        		}
	        	}
	        }
    	}
	}
}

function missileCollision(obj) {
	if(place_meeting(x, y, obj)) 
	{
		while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), obj))
		{
			x += lengthdir_x(1, dir);
			y += lengthdir_y(1, dir);
		}
		instance_destroy();
	}
}