//returns an array c[3] 
//c[0] = FIRST instance which collides with this laser (noone if it doesn't exist)
//c[1], c[2] = points of collision
function lightCollision(x1, y1, x2, y2, object, precise, notme)
{
	var rr = collision_line(x1, y1, x2, y2, object, precise, notme), rx = x2, ry = y2;
	if (rr != noone) {
	    var _p0 = 0;
	    var _p1 = 1;
	    repeat (ceil(log2(point_distance(x1, y1, x2, y2))) + 1) {
	        var np = _p0 + (_p1 - _p0) * 0.5;
	        var nx = x1 + (x2 - x1) * np;
	        var ny = y1 + (y2 - y1) * np;
	        var px = x1 + (x2 - x1) * _p0;
	        var py = y1 + (y2 - y1) * _p0;
	        var nr = collision_line(px, py, nx, ny, object, precise, notme);
	        if (nr != noone) {
	            rr = nr;
	            rx = nx;
	            ry = ny;
	            _p1 = np;
	        } else _p0 = np;
	    }
	}
	//arrays can be passed as literals in which they behave as 'primitive' types that are passed around as values
	return [rr, rx, ry];
}
