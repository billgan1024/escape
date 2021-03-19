image_angle += 1;
path_position += spd;
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