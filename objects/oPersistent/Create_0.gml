//default font stuff (all draw events will set the font stuff back to the default if they change)
dsfont(fMain);
dscolour(c_white);
dshalign(fa_center);
dsvalign(fa_middle);

//initialize http variables
post = undefined;
headerMap = ds_map_create();
ds_map_add(headerMap, "Content-Type", "application/json");
transmitData = true;
receiveData = false;
shiftTime = false;
a = array_create(16, infinity);
randomize();
h = window_get_height();
window_set_size(h/3*4, h/4*3);
a[1] = 1;
t = 0;
gameSpd = 1;

//input data
enum in {
	left, right, up, down, 
	space, shift, enter, esc, length
}
//a[5] = 240;
global.keyCodes = [vk_left, vk_right, vk_up, vk_down, vk_space, vk_shift, vk_enter, vk_escape];
//bind WASD to arrow keys
keyboard_set_map(ord("W"), vk_up); keyboard_set_map(ord("A"), vk_left); keyboard_set_map(ord("S"), vk_down); keyboard_set_map(ord("D"), vk_right);

input2 = array_create(in.length);
fileName = "data.dat";
data = ds_map_create();
if(file_exists(fileName)) {
	ds_map_destroy(data);
	data = ds_map_secure_load(fileName);
}
else init();
//read in values in an array so that it can be used in the draw event
if(ds_map_find_value(data, "fs")) window_set_fullscreen(true);
//log("idx", asset_get_index("utilScripts"));

//this enum assigns numbers to values 
//gs.menu = 0, gs.game = 1, and so on
//menu -> (select, options)
//paused -> optionsGame

enum gs {
	menu, game, select, options, paused, optionsGame, username, length
}
menuData = array_create(gs.length, []);
initMenu();
//since we're implementing this functionality as an update, there will be ppl who have a data file
//but not a username field, so update that accordingly
gameState = is_undefined(data[?"username"]) ? gs.menu : gs.menu;

//parent array: p[i] represents what screen to go back to (-1 if root)
parent = [-1, -1, gs.menu, gs.menu, -1, gs.paused, -1];
//row[i], col[i] = number of rows and columns for each menu state
row = [4, 0, 5, 6, 4, 5, 2];
col = [1, 0, 8, 1, 1, 1, 1];

//r, c = current row, col; cur = current menu item instance ID
//tr, tc = row, col after transition
//pr, pc = previous row, previous col which will be used when u press escape
r = 0; c = 0; pr = 0; pc = 0; tr = 0; tc = 0;
cur = noone;

//camera data for levels (cameraData[0] = dummy value)
//it is calculated with boundary objects
cameraData = array_create(33, -1);
//show_debug_message(cameraData);

//fps (for debug)
fpsLevel = 3;
debugFps = [30, 60, 120, 240];

//rectangle selector location (by default, it's at the 'Play' button)
//relative location (upon draw, add by vx and vy)
//to lerp these values, two arrays are required
//[xpos, ypos, w, h]
selectorFrom = [0, 0, 0, 0];
selectorTo = [0, 0, 0, 0];

//snap: whether the rectangle will instantly snap to the
//current button selected upon draw
//pressing any arrow key will disable snap
snap = true; 

//transition data (handles menu AND room transitions)
state = 0; alpha = 1; 
tAlpha = 0;
destState = -1; destRoom = -1;
canInteract = false; 
//for buttons which take up multiple rows
horizontal = true;

paused = false;

//enable interacting and disable snap
a[4] = inputDelay;

//titles
titles = ["Escape", "", "Level Select", "Options", "Game Paused", "Options", ""];
menuTitles = [/*data[?"lvl"] > 1 ? "Continue" : "Play"*/"Play", "Level Select", "Options", "Quit"];
pauseTitles = ["Back to Game", "Retry Level", "Options", "Main Menu"];
navigationHelp = "Arrow/WASD Keys: Navigate\nEnter: Select\nEsc: Back";

//[timeFactor as a multiple of the desired game speed, total number of frames that have passed]
//update these according to delta time in the step event
//keep a separate one for persistent's updates
time = [1, 0];
pTime = [1, 0];

a[3] = random_range(240, 300);

global.ps_above = part_system_create(); global.ps_below = part_system_create(); global.ps_bg = part_system_create();
part_system_depth(global.ps_above, layer_get_depth("Above")); part_system_depth(global.ps_below, layer_get_depth("Below")); part_system_depth(global.ps_bg, layer_get_depth("Below"));
part_system_automatic_update(global.ps_above, false); part_system_automatic_update(global.ps_below, false); part_system_automatic_update(global.ps_bg, false);

//initial audio gain for music and sounds (map which tracks default gain of audio)
//ALWAYS use soundGain[i] as a baseline if you want to scale audio volume up/down
musics = [aMenu, aGame];
musicGain = [gain(aMenu), gain(aGame)];
sounds = [aScroll, aSelect, aPause, aCoin, aExplosion, aExplosion2, aGem, aJump, aLaser, 
aShoot, aSplat, aDoor, aJump2, aPlatform, aShoot, aCamOn, aCamOff, aLaunch];
soundGain = array_create(array_length(sounds));
for(var i = 0; i < array_length(sounds); i++) soundGain[i] = gain(sounds[i]); 

//set the appropriate gain
updateMusicVol();
updateSoundVol();

//attempt counter
attempts = 0;
//whether persistent will reset attempts on transition
resetAttempts = false;

//wasFocused (tracking the time when the window loses focus)
wasFocused = true;

//play menu music with the appropriate volume set
mus(aMenu);
//audio_sound_gain(m, 0, 0);