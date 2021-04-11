vsp = approach(vsp, maxGrav*gravDir, grav);
var actualSpd = hsp/4;
x += actualSpd;
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

if(place_meeting(x+actualSpd*sight, y, oJumpTrigger) && place_meeting(x, y+1, oGround)) {
	//jump (note that your y coord will update in vCollision
	//so you won't jump twice in two consecutive frames)
	vsp = -jumpSpd;
}
vCollision();