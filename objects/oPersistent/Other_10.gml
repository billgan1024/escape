/// @description 
t += 1/240;
updateSelector();

//smooth transition handler for menus and room switching
//when you want to initiate a menu transition, disable interacting and enable snapping
//menu transition: state = 1, room transition: state = 3
//specify a target gameState and target room and target r and c, when the transition
//fully hides the menu/covers the screen, the transition code activates
switch(state) {
	case 1: 
	alpha = approach(alpha, 0, fadeSpeed);
	if(alpha == 0) {
		//destroy all items and load the new gameState
		snap = true;
		with(oMenuItem) instance_destroy();
		gameState = destState; r = tr; c = tc;
		loadMenu(gameState); 
		state++;
	}
	break;
	case 2: 
	alpha = approach(alpha, 1, fadeSpeed);
	if(alpha == 1) { state = 0; canInteract = true; snap = false; }
	break;
	case 3: 
	tAlpha = approach(tAlpha, 1, fadeSpeed);
	if(tAlpha == 1) {
		snap = true;
		room_goto(destRoom); 
		with(oMenuItem) instance_destroy();
		gameState = destState; r = tr; c = tc; loadMenu(gameState); 
		part_particles_clear(global.ps_above);
		part_particles_clear(global.ps_below);
		//automatically play the queued song and reset it
		if(destSong != -1) { mus(destSong); destSong = -1; }
		//reset attempts if necessary
		if(resetAttempts) { attempts = 0; resetAttempts = false; }
		state++;
	}
	break;
	case 4: 
	tAlpha = approach(tAlpha, 0, fadeSpeed);
	if(tAlpha == 0) { state = 0; canInteract = true; snap = false; }
	break;
}

//handle mouse events (again, only if canInteract is true)
var hover = false;
with(oMenuItem) {
	if(mouseOver(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset) && other.canInteract && willScale) {
		scale = smoothApproach(scale, 1, 0.3, 0.005);
		hover = true;
		if(other.input[1][in.mbLeft] && !is_undefined(enter)) {
			//instantly snap the cursor onto the clicked element so that any interaction will update
			//cur, which will represent the clicked element
			if(willMoveCursor) { other.r = r; other.c = c; other.cur = id; }
			//perform the update as usual and update the selector to match the clicked element and any 
			//changes in the width/height that might have occured
			with(other) { script_execute_ext(other.enter[0], other.enter[1]); snd(aSelect); checkSelected(); clearInput(); }
		}
	}
	else scale = smoothApproach(scale, baseScale, 0.3, 0.005);
}
if(menuData[gameState] == undefined) window_set_cursor(cr_none);
else window_set_cursor(hover ? cr_drag : cr_default);

//handle pausing and menus only if the menu isn't transitioning
if(canInteract) {
	if(menuData[gameState] != undefined) handleMenu();
	//always handle escape function 
	if(input[1][in.esc] && !is_undefined(escActions[gameState])) { 
		script_execute_ext(escActions[gameState][0], escActions[gameState][1]); snd(aSelect); clearInput(); 
	}
}
clearInput();