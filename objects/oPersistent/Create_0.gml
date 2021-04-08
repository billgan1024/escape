randomize();
h = window_get_height();
window_set_size(h/3*4, h/4*3);
t = 0;
gameSpd = 1;

a = array_create(16, infinity);

//input data
enum in {
	left, right, up, down, 
	keyW, keyA, keyS, keyD, 
	space, shift, enter, esc, length
}
//a[5] = 240;
global.keyCodes = array(vk_left, vk_right, vk_up, vk_down, ord("W"), ord("A"), ord("S"), ord("D"),
	vk_space, vk_shift, vk_enter, vk_escape);
input2 = array_create(in.length);
//load data
//if it's undefined, initialize default values
fileName = "data.dat";
data = ds_map_create();
if(file_exists(fileName)) {
	ds_map_destroy(data);
	data = ds_map_secure_load(fileName);
}
else init();
//read in values in an array so that it can be used in the draw event
if(ds_map_find_value(data, "fs")) window_set_fullscreen(true);

//this enum assigns numbers to values 
//gs.menu = 0, gs.game = 1, and so on
//menu -> (select, options)
//paused -> options2

enum gs {
	menu, game, select, options, paused, optionsGame
}
gameState = gs.menu;

//parent array: p[i] represents what screen to go back to (-1 if root)
parent = array(-1, -1, gs.menu, gs.menu, -1, gs.paused);
//row[i], col[i] = number of rows and columns for each menu state
row = array(4, 0, 5, 5, 4, 5);
col = array(1, 0, 8, 1, 1, 1);

//grid variables (with backtracking)
//tr, tc = row, col after transition
//pr, pc = previous row, previous col which will be used when u press escape
r = 0; c = 0; pr = 0; pc = 0; tr = 0; tc = 0;

//camera data for levels
//use -1 if you want no y-level checking
cameraData = [
	-1, -1, -1, -1, [[[0, 3600]], [[0, 3600]]]
];

//rectangle selector location (by default, it's at the 'Play' button)
//relative location (upon draw, add by vx and vy)
//to lerp these values, two arrays are required
selectorFrom = {
	xpos: 0, ypos: 0, w: 0, h: 0
}
selectorTo = {
	xpos: 0, ypos: 0, w: 0, h: 0
}

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
titles = array("Escape", "", "Level Select", "Options", "Game Paused", "Options");
menuTitles = array(data[?"lvl"] > 1 ? "Continue" : "Play", "Level Select", "Options", "Quit");
pauseTitles = array("Back to Game", "Retry Level", "Options", "Main Menu");

timeFactor = 1; gameTimer = 0;
//keep a separate timeFactor and gameTimer for persistent's updates
pTimeFactor = 1; pGameTimer = 0;

a[1] = 1; a[3] = random_range(60, 80);

global.ps_above = part_system_create();
global.ps_below = part_system_create();
part_system_depth(global.ps_above, layer_get_depth("Above"));
part_system_depth(global.ps_below, layer_get_depth("Below"));
part_system_automatic_update(global.ps_above, false);
part_system_automatic_update(global.ps_below, false);

//initial audio gain for music and sounds (map which tracks default gain of audio)
musics = array(aMenu, aGame);
musicGain = array(gain(aMenu), gain(aGame));
sounds = array(aScroll, aSelect, aPause, aCoin, aExplosion, aGem, aJump, aLaser, aShoot, aSplat, sDoor);
soundGain = array(gain(aScroll), gain(aSelect), gain(aPause), gain(aCoin), gain(aExplosion), gain(aGem), gain(aJump), gain(aLaser), gain(aShoot), gain(aSplat), gain(aDoor));

//set the appropriate gain
updateMusicVol();
updateSoundVol();

//play menu music with the appropriate volume set
mus(aMenu);