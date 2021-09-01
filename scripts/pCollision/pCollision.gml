function pCollision() {
	var p = instance_place(x, y+1, oHorizontalPlatform); 
	if(p != noone) {
		phsp = p.hsp; //log(x-p.x);
	} else phsp = 0;
	var q = instance_place(x, y+1, oFallingPlatform);
	if(q != noone && q.state == 0) { snd(aPlatform); q.state = 1; q.a[2] = 210; }
}