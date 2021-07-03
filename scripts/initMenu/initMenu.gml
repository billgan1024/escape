function initMenu() {
	enum gs {
		//this enum assigns numbers to values 
		//gs.menu = 0, gs.game = 1, and so on
		//levels: the list of custom levels you have in the menu 
		//edit: level editor room
		//username: if there is no username, prompt the user for one
		menu, game, select, options, paused, optionsGame, logIn, register, levels, edit, length
	}
	
	gameState = is_undefined(data[?"username"]) ? gs.menu : gs.menu;
	activeMenu = [true, false, true, true, true, true, true];
	//row[i], col[i] = number of rows and columns for each menu state
	maxRow = [4, 0, 5, 5, 4, 5, 3];
	maxCol = [1, 0, 8, 1, 1, 1, 1];
	
	//all constant text data for the menu screens
	titles = ["Escape", "", "Level Select", "Options", "Game Paused", "Options", "Log In", "Register", "Custom Levels", ""];
	bottomLeft = ["Bill Gan", "", "", "", "", "", "", "", "", ""];
	bottomRight = ["Arrow/WASD Keys: Navigate\nEnter: Select\nEsc: Back", "", "", "", "", "", "", "", "", ""];
	menuTitles = [/*data[?"lvl"] > 1 ? "Continue" : "Play"*/"Play", "Level Select", "Options", "Quit"];
	
	navigationHelp = "Arrow Keys/WASD/Mouse: Navigate\nEnter: Select\nEsc: Back"
	pauseTitles = ["Back to Game", "Retry Level", "Options", "Main Menu"];
	
	//[xpos, ypos, w, h], (x, y) is in the range (0, 0) to (vw, vh)
	selectorFrom = [0, 0, 0, 0];
	selectorTo = [0, 0, 0, 0];
	//r, c = current row, col; cur = current menu item instance ID
	//tr, tc = row, col after transition
	//pr, pc = previous row, previous col which will be used when u press escape
	r = 0; c = 0; tr = 0; tc = 0;
	pr = ds_stack_create(); pc = ds_stack_create();
	cur = noone; hover = noone;
	//bottom offset for drawing the selector properly
	vOffset = 0;
	
	assignMenuCreationFunctions();
}