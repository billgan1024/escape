//note that array_push and array_pop are the only functions that work with structs 
function initMenu() {
	enum gs {
		menu, game, select, options, paused, optionsGame, edit, username, length
	}
	
	gameState = is_undefined(data[?"username"]) ? gs.menu : gs.menu;
	activeMenu = [true, false, true, true, true, true, true];
	//row[i], col[i] = number of rows and columns for each menu state
	maxRow = [4, 0, 5, 6, 4, 6, 2, 0];
	maxCol = [1, 0, 8, 1, 1, 1, 1, 0];
	
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
	
	//menuData = array holding all of the UI elements for every state (initialized dynamically)
	menuData = array_create(gs.length);
	//instead of loading every menu at runtime, bind each one to a function which creates
	//all of the menu items automatically
	menuData[gs.menu] = [createMenuItems, []];
	menuData[gs.select] = [createSelectItems, []];
	menuData[gs.options] = [createOptionsItems, [gs.options]];
	menuData[gs.game] = undefined;
	menuData[gs.paused] = [createPausedItems, []];
	menuData[gs.optionsGame] = [createOptionsItems, [gs.optionsGame]];
	
	//escActions = static array holding the necessary actions performed when u press esc
	//substitute (pr, pc) with constants
	escActions = array_create(gs.length, undefined);
	escActions[gs.select] = [transitionTo, [gs.menu, -1, -1]];
	escActions[gs.options] = [transitionTo, [gs.menu, -1, -1]];
	escActions[gs.game] = [teleportTo, [gs.paused]];
	escActions[gs.paused] = [teleportTo, [gs.game]];
	escActions[gs.optionsGame] = [transitionTo, [gs.paused, -1, -1]]; 
}

function loadMenu(_gameState) {
	if(!is_undefined(menuData[_gameState])) {
		script_execute_ext(menuData[_gameState][0], menuData[_gameState][1]);
		checkSelected();	
	}
}

function handleMenu() {
	//pro tip: calling a function using id.f() will have the caller as that object
	//however, using script_execute(id.f) will have the caller as the original instance which called script_execute;
	//in this case, it's oPersistent
	//after every interaction, update the cursor if necessary
	if(input[1][in.left] && !is_undefined(cur.left)) { script_execute_ext(cur.left[0], cur.left[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.right] && !is_undefined(cur.right)) { script_execute_ext(cur.right[0], cur.right[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.up] && !is_undefined(cur.up)) { script_execute_ext(cur.up[0], cur.up[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.down] && !is_undefined(cur.down)) { script_execute_ext(cur.down[0], cur.down[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.enter] && !is_undefined(cur.enter)) { script_execute_ext(cur.enter[0], cur.enter[1]); snd(aSelect); checkSelected(); clearInput(); }
}