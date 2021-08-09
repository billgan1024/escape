function initMenu() {
	enum gs {
		//this enum assigns numbers to values 
		//gs.menu = 0, gs.game = 1, and so on
		//levels: the list of custom levels you have in the menu 
		//levelData: shown when you're editing the metadata or creating a new level in the menu room
		//edit: level editor room
		//username: if there is no username, prompt the user for one
		menu, game, select, options, paused, optionsGame, login, register, verifyEmail, levels, levelData, edit, length
	}
	
	gameState = is_undefined(data[?"username"]) ? gs.login : gs.menu;
	// gameState = gs.menu;
	activeMenu = [true, false, true, true, true, true, true];
	//row[i], col[i] = number of rows and columns for each menu state
	
	//metadata for every gamestate
	stateData = array_create(in.length);
	stateData[gs.menu]        = { maxRow: 4, maxCol: 1, title: "Escape" };
	stateData[gs.game]        = { maxRow: 0, maxCol: 0, title: "" };
	stateData[gs.select]      = { maxRow: 5, maxCol: 8, title: "Level Select" };
	stateData[gs.options]     = { maxRow: 5, maxCol: 1, title: "Options" };
	stateData[gs.paused]      = { maxRow: 4, maxCol: 1, title: "Game Paused" };
	stateData[gs.optionsGame] = { maxRow: 5, maxCol: 1, title: "Game Paused" };
	stateData[gs.login]       = { maxRow: 3, maxCol: 1, title: "Log In" };
	stateData[gs.register]    = { maxRow: 3, maxCol: 1, title: "Register" };
	stateData[gs.levels]      = { maxRow: 7, maxCol: 4, title: "Custom Levels" };
	stateData[gs.levelData]   = { maxRow: 2, maxCol: 4, title: "" };
	stateData[gs.edit]        = { maxRow: 0, maxCol: 0, title: "" };
	
	//all constant text data for the menu screens
	var str = "Arrow/WASD/Mouse: Navigate\nEnter/LMB: Select\nEsc: Back"; 
	bottomLeft = ["", "", "", "", "", "", "", "", "", ""];
	bottomRight = ["", "", "", "", "", "", "", "", "", ""];
	menuTitles = [/*data[?"lvl"] > 1 ? "Continue" : "Play"*/"Play", "Level Select", "Options", "Quit"];
	
	//selector info
	selector = [0, 0, 0, 0];
	vOffset = 0; vOffsetTo = 0;
	
	initTransition();
	
    selectorAlpha = alpha/5;
	
	//use this for easy access to individual elements
	//note that span elements will have multiple entries (the id will be filling up the entire row/column)
	//every time an object is created, make sure to update this array
	//every time we transition to a new state, make sure to clear the array
	itemIDs = ds_grid_create(8, 8); ds_grid_clear(itemIDs, undefined);
	
	//maintain a list of textbox ids so that you can extract text from them and also use tab to cycle through them
	textboxIDs = ds_list_create();
	
	//r, c = current row, col; cur = current menu item instance ID
	//tr, tc = row, col after transition
	//pr, pc = previous row, previous col which will be used when u press escape
	r = 0; c = 0; tr = 0; tc = 0;
	pr = ds_stack_create(); pc = ds_stack_create();
	cur = undefined;
	assignMenuCreationFunctions();
	assignMenuBackgroundItems();
	
	initNotification();
	
	//whether or not u are hovering above a button
	hover = false; 
}