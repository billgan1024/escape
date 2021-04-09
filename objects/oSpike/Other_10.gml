//convert spd to the appropriate value
var actualSpd = spd/path_get_length(path_index)/4;
path_position += actualSpd;
image_angle += log2(abs(spd))/2;
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