function getRotateSpd(s) {
	return 1 + abs(s)/4;
}

/// @param pathIndex
/// @param pathSpeed [0-1]
/// @param loop
/// @param [pos=0]
/// @param [offsetX=default]
/// @param [offsetY=default]
function path() {
	//in this new implementation, the spikes are always put in relative mode
	//if an hpath/vpath is selected, the new path will be created and destroyed on cleanup
	//if you specify hpath/vpath as the path, only put 
	var _pathIdx = argument0, _spd = argument1, _loop = argument2;
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
	//log(pos);
}

//take the current path of the user and apply it to a group of spikes
//with the option of applying circular speed and a starting angle
//remember to set a path first before calling this function
function generateSpikes(l, r, circularSpd, startingAngle, radial) {
	for(var i = l; i <= r; i++) {
		with(instance_create_layer(x + lengthdir_x(60*i, startingAngle), y + lengthdir_y(60*i, startingAngle), "Enemies", oSpike)) {
			pathIdx = other.pathIdx; spd = other.spd; loop = other.loop;
			angle = startingAngle; startAngle = angle; 
			offsetX = other.offsetX; offsetY = other.offsetY;
			radius = 60*i; pos = other.pos; startPos = pos;
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