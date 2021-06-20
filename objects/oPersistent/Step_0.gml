checkInputPressed(); 
//log("fps", fps);
//log("fps-real", fps_real);
//log(delta_time/1000000*fps);
pTime[0] = min(delta_time/1000000*debugFps[fpsLevel], 8);
if(window_has_focus() && (gameState != gs.paused && gameState != gs.optionsGame)) {
	time[0] = min(delta_time/1000000*debugFps[fpsLevel], 8);
} else {
	time[0] = 0; 
}	
//pause the game on unfocus window

if(window_has_focus() != wasFocused && gameState == gs.game) script_execute_ext(escActions[gs.game][0], escActions[gs.game][1]);
wasFocused = window_has_focus();
//update everything before persistent
step(time, updateLocal);
//update persistent (remember: it needs to update even while time[0] = 0)
//note that menu items are technically persistent objects
step(pTime, updateGlobal);