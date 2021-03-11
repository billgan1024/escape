randomize();
window_set_fullscreen(true);
alarms[3] = 50;
global.timeFactor = 1; gameTimer = 0;
layer_set_visible("Background", false);

audio_group_load(music);

global.ps_above = part_system_create();
part_system_depth(global.ps_above, -100);
global.ps_below = part_system_create();
part_system_depth(global.ps_below, 350);
part_system_automatic_update(global.ps_above, false);
part_system_automatic_update(global.ps_below, false);
part_system_automatic_update(0, false);
part_system_automatic_update(1, false);

alarms = array_create(16, infinity);
alarms[1] = random_range(30, 40);
noAlarms = ds_list_create();
ds_list_add(noAlarms, oGround);
ds_list_add(noAlarms, oMenu);
ds_list_add(noAlarms, oDisplay);
ds_list_add(noAlarms, oInvis);

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
ds_map_set(buttonNames, gs.select, [["1", "2", "3", "4"],
	["5", "6", "7", "8"], ["9", "10", "11", "12"], 
	["13", "14", "15", "16"]]);