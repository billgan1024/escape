vsp = approach(vsp, maxGrav, grav);
x += hsp;
if(place_meeting(x, y, oInvis)) {
	var b = instance_place(x, y, oInvis);
	if(hsp > 0) {
		var d = bbox_right-b.bbox_left; 
		x -= 2*d;
	} else {
		var d = b.bbox_right-bbox_left;
		x += 2*d;
	}
	hsp *= -1;
}

vCollision();