function resetArea() {
	log("reset area");
	with(oEnemy) { x = xstart; y = ystart; hsp = hspStart; }
	with(oSpike) { 
		image_angle = 0; angle = startAngle;
		if(pathIdx != -1) {
			pos = startPos; 
			//note: in this current state, u need to set the position if spikes update their position before oGame, so 
			//we need to put oGame's logic in begin step
			x = path_get_x(pathIdx, pos) + lengthdir_x(radius, angle) + offsetX;
			y = path_get_y(pathIdx, pos) + lengthdir_y(radius, angle) + offsetY;
		}
	}
	with(oCoin) { image_angle = 0; x = xstart; t = 0; a[1] = random_range(90, 120); }
	with(oPlatform) {
		t = 0;
		//only set falling platforms back to their original state
		if(object_index == oFallingPlatform) {
			 state = 0; a[1] = random_range(40, 60); a[2] = infinity; 
			 deactivated = false; image_alpha = 1;
		}
	}
	with(oFallingPlatform) { state = 0; a[1] = random_range(40, 60); a[2] = infinity; }
	instance_destroy(oBullet);
	instance_destroy(oMissile, false);	
	with(oBulletCannon) { a[1] = delayStart; a[2] = infinity; }
	with(oMissileCannon) { 
		a[1] = delayStart; a[2] = infinity; image_angle = angleStart; 
		len = 0; laserAlpha = 0;
	}
	with(oLaserCannon) {
		state = 0; a[1] = delayStart; a[2] = infinity; t = 0; len = 0; a[3] = 8;
		image_angle = angleStart;
	}
	with(oGem) { t = 0; a[1] = random_range(15, 60); }
	with(oGemOrange) { state = 0; t = 0; a[1] = random_range(15, 60); }
	part_particles_clear(global.ps_above);
	part_particles_clear(global.ps_below);
}
