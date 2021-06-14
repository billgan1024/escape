checkInputPressed(); 
//log("fps-real", fps_real);
//log(delta_time/1000000*fps);
pTime[0] = min(delta_time/1000000*debugFps[fpsLevel], 8);
if(window_has_focus() && (gameState != gs.paused && gameState != gs.optionsGame)) {
	time[0] = min(delta_time/1000000*debugFps[fpsLevel], 8);
} else {
	time[0] = 0; 
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
step(time, updateLocal);
//update persistent (remember: it needs to update even while time[0] = 0)
step(pTime, updateGlobal);