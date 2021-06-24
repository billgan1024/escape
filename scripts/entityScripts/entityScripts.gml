/// @param hsp
/// @param [gravDir=1]
function setEnemy(_hsp) {
	if(argument_count == 2) { gravDir = argument[1]; gravDirStart = gravDir; }
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
	var _angularSpd = 0; if(argument_count == 4) angularSpd = argument[3];
	a[1] = _delayStart; delayStart = _delayStart;
	delayActive = _delayActive; delayRest = _delayRest; angleStart = image_angle;
	angularSpd = _angularSpd;
}

/// @param radius
/// @param period
/// @param [flip=false]
function setWave(_radius, _period) {
	//note: setWave can also be used to set laser cannon stuff
	if(object_index == oCoin || object_index == oLaserCannon) sway = true;
	radius = _radius; period = _period; 
	if(argument_count == 3) flip = argument[2];
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