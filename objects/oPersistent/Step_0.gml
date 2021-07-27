checkInputPressed(); 
//log("fps", fps);
//log("fps-real", fps_real);
//log(delta_time/1000000*fps);
time[0] = min(delta_time/1000000*debugFps[fpsLevel], 8);
//pause the game on unfocus window

if(/*window_has_focus() != wasFocused*/ os_is_paused() && gameState == gs.game) {
	script_execute_ext(escActions[gs.game][0], escActions[gs.game][1]);
}
wasFocused = window_has_focus();
//bugfix: keep everything in the same delta time game loop
step();