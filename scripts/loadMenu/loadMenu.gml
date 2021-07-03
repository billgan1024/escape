function loadMenu(_gameState) {
	if(!is_undefined(menuData[_gameState])) {
		script_execute_ext(menuData[_gameState][0], menuData[_gameState][1]);
		checkSelected();	
	}
}