randomize();
window_set_fullscreen(true);
global.timeFactor = 1; gameTimer = 0;
layer_set_visible("Background", false);

global.ps_above = part_system_create();
part_system_depth(global.ps_above, -100);
global.ps_below = part_system_create();
part_system_depth(global.ps_below, 350);
part_system_automatic_update(global.ps_above, false);
part_system_automatic_update(global.ps_below, false);
part_system_automatic_update(0, false);
part_system_automatic_update(1, false);

alarms = array_create(16, infinity);
alarms[1] = random_range(20, 30);
noAlarms = ds_list_create();
ds_list_add(noAlarms, oGround);
ds_list_add(noAlarms, oMenu);
ds_list_add(noAlarms, oBlink);
ds_list_add(noAlarms, oDisplay);

enum gs {
	menu = 0,
	select = 1,
	options = 2,
	game = 3
}

global.gameState = gs.menu;
//initialize menu data
buttonNames = ds_map_create();
ds_map_set(buttonNames, gs.menu, [["Play"], ["Level Select"], 
	["Options"], ["Quit"]]);