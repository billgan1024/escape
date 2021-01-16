function collision() {
	if(place_meeting(x+hsp+khsp, y, oGround))
	{
		while(!place_meeting(x+sign(hsp+khsp), y, oGround)) x += sign(hsp+khsp);
		hsp = 0; khsp = 0;
	}
	x += hsp+khsp;
	if(place_meeting(x, y+vsp+kvsp, oGround))
	{
		while(!place_meeting(x, y+sign(vsp+kvsp), oGround)) y += sign(vsp+kvsp);
		vsp = 0; kvsp = 0;
	}
	y += vsp+kvsp;	
}

function applyGrav() {
	if((!keyboard_check(vk_up) && !keyboard_check(ord("W")) && !keyboard_check(vk_space)) && vsp < 0) vsp += grav;
	//if((place_meeting(x+1, y, oGround) || place_meeting(x-1, y, oGround)) && vsp > 0)
		//vsp = approach(vsp, maxGrav/3, grav/3);	
	//else
	vsp = approach(vsp, maxGrav, grav);	
}

function swingSword() {
	swordAngle = angle_approach(swordAngle, angleTo, 5);
	if(swordAngle == angleTo)
	{
		isAttacking = false;
	}
}

function checkBlink() 
{
	if(rmb && canBlink)
	{
		canBlink = false; imgAlpha = 0; alarms[4] = 480;
		audio_play_sound(aBlink, 0, false);
		ring(c_white); isAttacking = false; 
		state = "blink"; alarms[2] = blinkTime;
		var d = point_direction(x, y, mouse_x, mouse_y);
		hsp = lengthdir_x(blinkSpd, d);
		vsp = lengthdir_y(blinkSpd, d);
	}
}

function checkAttack() {
	if(lmb && !isAttacking) { 
		audio_play_sound(aSwing, 0, false);
		isAttacking = true;
		var dir = point_direction(x, y, mouse_x, mouse_y);
		var d1 = dir-60, d2 = dir+60;
		if(atkDir)
		{
			swordAngle = d1; angleTo = d2;
		}
		else { swordAngle = d2; angleTo = d1; }
		atkDir = !atkDir;
	}
}

function checkEnemy() {
	if(place_meeting(x, y, oEnemy)) death();
}

function death() {
	audio_play_sound(aExplosion, 0, false);
	instance_destroy();
	effect_create_above(ef_firework, x, y, 1, c_white);
	oGame.shake = 10;	
	oGame.alarms[1] = 120;
}