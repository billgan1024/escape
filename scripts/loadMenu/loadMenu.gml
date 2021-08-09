function loadMenu(_destState) {
	//loads a destination state which can either be a gamestate or an array containing a gamestate + additional arguments
	//otherwise, you load the gameState with the default arguments
	if(is_array(_destState)) {
		gameState = _destState[0];
		script_execute_ext(menuData[gameState][0], _destState[1]);
	} else {
		gameState = _destState;
		script_execute_ext(menuData[gameState][0], menuData[gameState][1]);
	}
}