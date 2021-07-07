function angleApproach(current, target, turnSpd) {
	//we assume that all angles are in [0, 360) and the angle returned will also be in [0, 360)
	var d = angle_difference(current, target), angle1 = (current-turnSpd+360)%360, angle2 = (current+turnSpd)%360;
	if(abs(d) <= turnSpd) return target;
	else {
		if(abs(angle_difference(angle1, target)) < abs(angle_difference(angle2, target))) return angle1;
		else return angle2;
	}
}