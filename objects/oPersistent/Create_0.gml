a = array_create(16, infinity);
//default font stuff (all draw events will set the font stuff back to the default if they change)
dsfont(fMain); dscolour(c_white); dshalign(fa_center); dsvalign(fa_middle);

//keyboard automation
autoKey = ds_queue_create();

//initialize http variables
post = undefined;
global.headerMap = ds_map_create();
global.headerMap[?"Content-Type"] = "application/json";

global.production = true;
receiveData = false;
testObjects = false;
keyAutomation = false;

transmitData = global.production;
shiftTime = !global.production;
configSecrets();

randomize();
h = display_get_height();
window_set_size(h/3*4, h/4*3);
a[1] = 1;
t = 0;

//input data
enum in {
	left, right, up, down, space, shift, enter, esc, tab, mbLeft, mbRight, mbMiddle, length 
}

//a[5] = 240;
global.inputCodes = [vk_left, vk_right, vk_up, vk_down, vk_space, vk_shift, vk_enter, vk_escape, vk_tab, mb_left, mb_right, mb_middle];
bindInput();

for(var i = 0; i < 3; i++) input[i] = array_create(in.length);

configSecrets();
loadSettings();
initCustomLevels();
window_set_fullscreen(data[?"fs"]);

initMenu();
loadMenu(gameState);
changeCursor(0, 0, true);

//camera data for levels (cameraData[0] = dummy value)
//it is calculated with boundary objects
cameraData = array_create(33, -1);
//show_debug_message(cameraData);

//fps (for debug)
fpsLevel = 3;
debugFps = [30, 60, 120, 240];

snap = true; 
paused = false;

//enable interacting and disable snap
a[4] = inputDelay;

//[timeFactor as a multiple of the desired game speed, total number of frames that have passed]
//update these according to delta time in the step event
//keep a separate one for persistent's updates
time = [1, 0];
pTime = [1, 0];

a[3] = random_range(180, 240);

global.ps_above = part_system_create(); global.ps_below = part_system_create(); global.ps_bg = part_system_create();
part_system_depth(global.ps_above, layer_get_depth("Above")); part_system_depth(global.ps_below, layer_get_depth("Below")); part_system_depth(global.ps_bg, layer_get_depth("Below"));
part_system_automatic_update(global.ps_above, false); part_system_automatic_update(global.ps_below, false); part_system_automatic_update(global.ps_bg, false);

//initial audio gain for music and sounds (map which tracks default gain of audio)
//ALWAYS use soundGain[i] as a baseline if you want to scale audio volume up/down
musics = [aMenu, aGame];
musicGain = [gain(aMenu), gain(aGame)];
sounds = [aScroll, aSelect, aCoin, aExplosion, aExplosion2, aGem, aJump, aLaser, 
 aSplat, aShoot, aDoor, aJump2, aPlatform, aCamOn, aCamOff, aLaunch];
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
//wasFocused = true;

mus(aMenu); 
//audio_sound_gain(m, 0, 0);