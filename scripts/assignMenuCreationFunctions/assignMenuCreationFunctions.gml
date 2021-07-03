function assignMenuCreationFunctions() {
	//menuData = array holding all of the functions to dynamically generate UI elements
	menuData = array_create(gs.length);
	//instead of loading every menu at runtime, bind each one to a function which creates
	//all of the menu items automatically
	menuData[gs.menu] = [createMenuItems, []];
	menuData[gs.select] = [createSelectItems, []];
	menuData[gs.options] = [createOptionsItems, [gs.options]];
	menuData[gs.game] = undefined;
	menuData[gs.paused] = [createPausedItems, []];
	menuData[gs.optionsGame] = [createOptionsItems, [gs.optionsGame]];
	menuData[gs.logIn] = [createLoginItems, []];
	menuData[gs.register] = [createRegisterItems, []];
	menuData[gs.levels] = [createLevelsItems, []];
	menuData[gs.edit] = undefined;
	
	//escActions = static array holding the necessary actions performed when u press esc
	//substitute (pr, pc) with constants
	escActions = array_create(gs.length, undefined);
	escActions[gs.select] = [transitionTo, [gs.menu, -1, -1]];
	escActions[gs.options] = [transitionTo, [gs.menu, -1, -1]];
	escActions[gs.game] = [teleportTo, [gs.paused]];
	escActions[gs.paused] = [teleportTo, [gs.game]];
	escActions[gs.optionsGame] = [transitionTo, [gs.paused, -1, -1]]; 
}