function checkEnemy() {
	if(y-30 >= room_height) death();
	if(place_meeting(x, y, oEnemyParent)) death();
}

function collision() {
	if(place_meeting(x+hsp+khsp, y, oGround))
	{
		while(!place_meeting(x+sign(hsp+khsp), y, oGround)) x += sign(hsp+khsp);
		hsp = 0; khsp = 0;
	}
	x += hsp+khsp;
	if(place_meeting(x, y+vsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp), oGround)) y += sign(vsp);
		vsp = 0;
	}
	y += vsp;	
}

/// @param walkAcc
/// @param runAcc
function updateHsp(walkAcc, runAcc) {
	if(dash) hsp = approach(hsp, dir*(runSpd-abs(khsp)*3/4), runAcc); 
	else hsp = approach(hsp, dir*(walkSpd-abs(khsp)*3/4), walkAcc);
}

function updateVsp() {
	//apply more grav if player isn't holding jump
	if(!boosted && !jumpHeld && vsp < 0) vsp += grav*2;
	if(grip != 0 && vsp > 0)
	{ 
		if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*2); 
		else vsp = approach(vsp, maxGrav/3, grav/3); 
	}
	else if(vsp > 0 && down) vsp = smoothApproach(vsp, maxGrav*9/8, 0.03);
	else vsp = approach(vsp, maxGrav, grav);
}

function death() {
	snd(aExplosion); instance_destroy();
	firework(c_white);
	shrink(sPlayer);
	oGame.shake = 10;	
	oGame.a[1] = 120;
}