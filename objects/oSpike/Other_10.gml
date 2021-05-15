//key note: spd = actual pixels per frame
image_angle = (image_angle+1+abs(spd/4)) % 360;
if(angularSpd != 0) {
	angle = (angle + angularSpd) % 360;
	x = originX + lengthdir_x(radius, angle); y = originY + lengthdir_y(radius, angle);
} else {
	var actualSpd = spd/path_get_length(path_index);
	path_position += actualSpd;
	if(!rev) path_position = frac(path_position);
	else {
		if(path_position <= 0) {
			var d = -path_position;	
			path_position += 2*d;
			spd *= -1;
		} else if(path_position >= 1) {
			var d = path_position-1;	
			path_position -= 2*d;
			spd *= -1;
		}
	}
}