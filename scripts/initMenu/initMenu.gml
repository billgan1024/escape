function initMenu() {
	enum gs {
		//this enum assigns numbers to values 
		//gs.menu = 0, gs.game = 1, and so on
		//levels: the list of custom levels you have in the menu 
		//levelData: shown when you're editing the metadata or creating a new level in the menu room
		//edit: level editor room
		//username: if there is no username, prompt the user for one
		menu, game, select, options, paused, optionsGame, login, register, levels, levelData, edit, length
	}
	
	gameState = is_undefined(data[?"username"]) ? gs.login : gs.menu;
	activeMenu = [true, false, true, true, true, true, true];
	//row[i], col[i] = number of rows and columns for each menu state
	
	maxRow[gs.menu]        = 4;    maxCol[gs.menu]        = 1;
	maxRow[gs.game]        = 0;    maxCol[gs.game]        = 0;
	maxRow[gs.select]      = 5;    maxCol[gs.select]      = 8;
	maxRow[gs.options]     = 5;    maxCol[gs.options]     = 1;
	maxRow[gs.paused]      = 4;    maxCol[gs.paused]      = 1;
	maxRow[gs.optionsGame] = 5;    maxCol[gs.optionsGame] = 1;
	maxRow[gs.login]       = 3;    maxCol[gs.login]       = 1;
	maxRow[gs.register]    = 3;    maxCol[gs.register]    = 1;
	maxRow[gs.levels]      = 7;    maxCol[gs.levels]      = 4;
	maxRow[gs.levelData]   = 2;    maxCol[gs.levelData]   = 4;
	maxRow[gs.edit]        = 0;    maxCol[gs.edit]        = 0;
	
	//all constant text data for the menu screens
	var str = "Arrow/WASD/Mouse: Navigate\nEnter/LMB: Select\nEsc: Back"; 
	titles = ["Escape", "", "Level Select", "Options", "Game Paused", "Options", "Log In", "Register", "Custom Levels", ""];
	bottomLeft = ["Bill Gan", "", "", "", "", "", "", "", "", ""];
	bottomRight = [str, "", "", "", "", "", str, "", "", ""];
	menuTitles = [/*data[?"lvl"] > 1 ? "Continue" : "Play"*/"Play", "Level Select", "Options", "Quit"];
	
	navigationHelp = "Arrow Keys/WASD/Mouse: Navigate\nEnter: Select\nEsc: Back"
	pauseTitles = ["Back to Game", "Retry Level", "Options", "Main Menu"];
	
	selector = [0, 0, 0, 0];
	vOffset = 0; vOffsetTo = 0;
	
	//use this for easy access to individual elements
	//note that span elements will have multiple entries (the id will be filling up the entire row/column)
	//every time an object is created, make sure to update this array
	//every time we transition to a new state, make sure to clear the array
	itemIDs = ds_grid_create(8, 8); ds_grid_clear(itemIDs, undefined);
	//r, c = current row, col; cur = current menu item instance ID
	//tr, tc = row, col after transition
	//pr, pc = previous row, previous col which will be used when u press escape
	r = 0; c = 0; tr = 0; tc = 0;
	pr = ds_stack_create(); pc = ds_stack_create();
	cur = undefined; 
	
	assignMenuCreationFunctions();
	assignMenuBackgroundItems();
}