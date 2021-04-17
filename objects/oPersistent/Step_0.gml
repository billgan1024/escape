checkInputPressed();
pTimeFactor = min(delta_time/1000000*debugFps[fpsLevel]*gameSpd, 8);
if(window_has_focus() && (gameState != gs.paused && gameState != gs.optionsGame)) {
	timeFactor = min(delta_time/1000000*debugFps[fpsLevel]*gameSpd, 8);
} else {
	timeFactor = 0; 
}	
//pause the game on unfocus window
if(window_has_focus() != wasFocused) {
	if(gameState == gs.game) { 
		gameState = gs.paused; r = 0; c = 0;
		canInteract = false; snap = true; a[4] = inputDelay;
	}
}
wasFocused = window_has_focus();
//update everything before persistent
gameTimer += timeFactor; 
if(timeFactor != 0 && floor(gameTimer) != floor(gameTimer - timeFactor))
{
	var _remainder = floor(gameTimer) - floor(gameTimer - timeFactor);
	
	repeat _remainder
	{
		part_system_update(global.ps_above);
		part_system_update(global.ps_below); 
		//step
		with(all) {
			if(object_index != oPersistent) update();
		}
	}
}

//update persistent (remember: it needs to update even while gameTimer = 0
pGameTimer += pTimeFactor;
if(floor(pGameTimer) != floor(pGameTimer - pTimeFactor))
{
	var _remainder = floor(pGameTimer) - floor(pGameTimer - pTimeFactor);
	repeat _remainder { 
		part_system_update(global.ps_bg);
		update(); 
	}
}