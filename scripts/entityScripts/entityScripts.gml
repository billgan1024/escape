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