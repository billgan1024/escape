checkInputPressed();
pTimeFactor = min(delta_time/1000000*240, 8);
if(window_has_focus() && gameState != gs.paused) {
	timeFactor = min(delta_time/1000000*240, 8);
} else {
	timeFactor = 0;
}	

gameTimer += timeFactor; 
if(floor(gameTimer) != floor(gameTimer - timeFactor))
{
	var _remainder = floor(gameTimer) - floor(gameTimer - timeFactor);
	
	repeat _remainder
	{
		with(all) {
			if(object_index != oPersistent) update();
		}
	}
}

//update persistent
pGameTimer += pTimeFactor;
if(floor(pGameTimer) != floor(pGameTimer - pTimeFactor))
{
	var _remainder = floor(pGameTimer) - floor(pGameTimer - pTimeFactor);
	repeat _remainder { 
		part_system_update(global.ps_above);
		part_system_update(global.ps_below); 
		update(); 
	}
}

