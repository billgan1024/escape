function applyGrav() {
	if(!keyboard_check(vk_up) && !keyboard_check(vk_space) && vsp < 0) vsp += grav;
	/*if((place_meeting(x+1, y, oGround) || place_meeting(x-1, y, oGround)) && vsp > 0 &&
		(keyboard_check(vk_left) || keyboard_check(vk_right)))
	{ 
		if(vsp > maxGrav/3) vsp = approach(vsp, maxGrav/3, grav*2); 
		else vsp = approach(vsp, maxGrav/3, grav/3); 
	}
	else 
	{*/
		if(vsp > 0 && keyboard_check(vk_down)) vsp = smooth_approach(vsp, maxGrav*9/8, 0.03);
		else vsp = approach(vsp, maxGrav, grav);
	//}
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
	/*if(rmb && canBlink)
	{
		canBlink = false; imgAlpha = 0; alarms[4] = blinkDelay;
		audio_play_sound(aBlink, 0, false);
		ring(c_white);
		//with(instance_create_layer(x, y, "Ground", oParticle)) s = sSphere2; 
		isAttacking = false; 
		state = "blink"; alarms[2] = blinkTime;
		var d = point_direction(x, y, mouse_x, mouse_y);
		hsp = lengthdir_x(blinkSpd, d);
		vsp = lengthdir_y(blinkSpd, d);
	}*/
}

function checkAttack() {
	if(lmb && canAttack) { 
		canAttack = false; alarms[3] = attackDelay;
		audio_play_sound(aSwing, 0, false);
		isAttacking = true;
		swordDir = point_direction(x, y, mouse_x, mouse_y);
		var d1 = swordDir-90, d2 = swordDir+90;
		if(atkDir)
		{
			swordAngle = d1; angleTo = d2;
		}
		else { swordAngle = d2; angleTo = d1; }
		atkDir = !atkDir;
	}
}

function checkEnemy() {
	if(place_meeting(x, y, oEnemyParent))
	{
		var e = instance_nearest(x, y, oEnemyParent);
		if(e.object_index == oEnemy) {
			if(y <= e.y-30) {
				with(e) instance_destroy();
				vsp = -jumpSpd;
			} else death();
		} else  death();
	}
	if(place_meeting(x, y, oProjectile))
	{
		var b = instance_nearest(x, y, oProjectile);
		if(!b.friendly) death();
	}
}

function death() {
	audio_play_sound(aExplosion, 0, false);
	instance_destroy();
	firework(c_white);
	playershrink();
	//effect_create_above(ef_firework, x, y, 1, c_white);
	oGame.shake = 10;	
	oGame.alarms[1] = 150;
}