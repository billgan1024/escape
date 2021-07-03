if(pathIdx != -1) {
	var actualSpd = spd/path_get_length(pathIdx);
	pos += actualSpd;
	if(loop) pos = frac(pos);
	else {
		if(pos <= 0) {
			var d = -pos;	
			pos += 2*d;
			spd *= -1;
		} else if(pos >= 1) {
			var d = pos-1;	
			pos -= 2*d;
			spd *= -1;
		}
	}
	angle = (angle + angularSpd + 360) % 360;
	//add offsetX and offsetY to account for when the spike is isolated from the original path location
	//basically, this represents that the whole path is translated by that vector
	x = path_get_x(pathIdx, pos) + lengthdir_x(radius, angle) + offsetX;
	y = path_get_y(pathIdx, pos) + lengthdir_y(radius, angle) + offsetY;
}
image_angle = (image_angle+rotateSpd) % 360;