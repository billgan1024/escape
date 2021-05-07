/// @description 
t += 1/240;
updateSelector();
//show_debug_message(keyboard_lastkey);
//update whether horizontal controls are allowed
horizontal = !((gameState == gs.select && r == 4));

//smooth transition handler for menus and room switching
//when you want to initiate a menu transition, disable interacting and enable snapping
//menu transition: state = 1, room transition: state = 3
//specify a target gameState and target room and target r and c, when the transition
//fully hides the menu/covers the screen, the transition code activates
switch(state) {
	case 1: 
	alpha = approach(alpha, 0, fadeSpeed);
	if(alpha == 0) {
		//swap game states
		gameState = destState; r = tr; c = tc;
		state++;
	}
	break;
	case 2: 
	alpha = approach(alpha, 1, fadeSpeed);
	if(alpha == 1) { state = 0; canInteract = true; snap = false; }
	break;
	//handle any room transition, whether it's from menu -> game
	//or when u go to another level
	case 3: 
	tAlpha = approach(tAlpha, 1, fadeSpeed);
	if(tAlpha == 1) {
		gameState = destState; room_goto(destRoom); r = tr; c = tc; 
		//clear all particles
		part_particles_clear(global.ps_above);
		part_particles_clear(global.ps_below);
		//part_system_clear(global.ps_bg);
		//part_system_automatic_update(global.ps_bg, false);
		//part_system_depth(global.ps_bg, layer_get_depth("Below"));
		//swap songs only if you stopped the audio in the transition menu -> game
		if(gameState == gs.game && !audio_is_playing(aGame)) mus(aGame);
		else if(gameState == gs.menu && !audio_is_playing(aMenu)) mus(aMenu);
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

//handle pausing and menus only if the menu isn't transitioning
if(canInteract) handleMenu();
clearPressed();