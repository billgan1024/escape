/// @description step event
t += 1/240;
updateSelector();

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
	case 3: 
	tAlpha = approach(tAlpha, 1, fadeSpeed);
	if(tAlpha == 1) {
		gameState = destState; room_goto(destRoom); r = tr; c = tc; 
		part_system_clear(global.ps_above);
		part_system_clear(global.ps_below);
		//play the correct song as you're fading in
		if(gameState == gs.game) mus(aGame);
		else if(gameState == gs.menu) mus(aMenu);
		state++;
	}
	break;
	case 4: 
	tAlpha = approach(tAlpha, 0, fadeSpeed);
	if(tAlpha == 0) { state = 0; canInteract = true; snap = false; }
	break;
}

//handle pausing 
if(gameState == gs.game || gameState == gs.paused) {
	if(ds_map_find_value(global.inputs2, vk_escape)) {
		if(gameState == gs.game) { 
			gameState = gs.paused; snd(aPause); r = 0; c = 0;
			canInteract = false; snap = true; a[4] = inputDelay;
		}
		else gameState = gs.game;
	}
}
//handle menus
if(gameState != gs.game && canInteract) {
	//menu navigation controls (only activate if state == 0 and the selector isn't moving)
	if(ds_map_find_value(global.inputs2, vk_down) || ds_map_find_value(global.inputs2, ord("S"))) {
		r = (r+1) % row[gameState];
		canInteract = false; a[2] = inputDelay; 
		snd(aScroll);
	}
	if(ds_map_find_value(global.inputs2, vk_up) || ds_map_find_value(global.inputs2, ord("W"))) {
		r = (r-1+row[gameState]) % row[gameState];
		canInteract = false; a[2] = inputDelay; 
		snd(aScroll);
	}
	if((ds_map_find_value(global.inputs2, vk_right) || ds_map_find_value(global.inputs2, ord("D"))) && horizontal) {
		if((gameState == gs.options || gameState == gs.optionsGame) && (r == 0 || r == 1)) {
			if(r == 0) {
				//update sound
				ds_map_replace(data, "sfx", min(100, ds_map_find_value(data, "sfx")+10));
				updateSoundVol();
				save();
			} else {
				//update music
				ds_map_replace(data, "mus", min(100, ds_map_find_value(data, "mus")+10));
				updateMusicVol();
				save();
			}
			snd(aScroll);
		} else if(col[gameState] > 1) {
			c = (c+1) % col[gameState];
			canInteract = false; a[2] = inputDelay; 
			snd(aScroll);
		}
	}
	if((ds_map_find_value(global.inputs2, vk_left) || ds_map_find_value(global.inputs2, ord("A"))) && horizontal) {
		if((gameState == gs.options || gameState == gs.optionsGame) && (r == 0 || r == 1)) {
			if(r == 0) {
				//update sound
				ds_map_replace(data, "sfx", max(0, ds_map_find_value(data, "sfx")-10));
				updateSoundVol();
				save();
			} else {
				//update music
				ds_map_replace(data, "mus", max(0, ds_map_find_value(data, "mus")-10));
				updateMusicVol();
				save();
			}
			snd(aScroll);
		} else if(col[gameState] > 1) {
			c = (c-1+col[gameState]) % col[gameState];
			canInteract = false; a[2] = inputDelay; 
			snd(aScroll);
		}
	}
	if(ds_map_find_value(global.inputs2, vk_enter)) {
		switch(gameState) {
			case gs.menu:
			switch(r) {
				case 0: audio_stop_sound(aMenu); transitTo(gs.game, level1);
				break;
				case 1: goForward(gs.select);
				break;
				case 2: goForward(gs.options);
				break;
				case 3: game_end();
				break;
			}
			break;
			case gs.select:
			if(r == 4) goBack(); 
			else {
				var lvl = 8*r+c+1;
				//go to a particular level if you have unlocked it
				if(ds_map_find_value(data, "lvl") >= lvl) {
					audio_stop_sound(aMenu);
					transitTo(gs.game, asset_get_index("level" + string(lvl)));
				}
			}
			break;
			//options and optionsGame represent the same state
			case gs.options:
			case gs.optionsGame:
			if(r == 4) goBack(); 
			else {
				switch(r) {
					case 2:
						window_set_fullscreen(!window_get_fullscreen());
						ds_map_replace(data, "fs", window_get_fullscreen());
						save();
						window_set_size(h/3*4, h/4*3);
						a[1] = 10;
					break;
					
					case 3:
					ds_map_replace(data, "timer", !ds_map_find_value(data, "timer"));
					save();
					break;
				}
			}
			break;
			case gs.game: paused = !paused;
			break;
			case gs.paused:
			switch(r) {
				case 0: gameState = gs.game;
				break;
				case 2: goForward(gs.optionsGame);
				break;
				case 3: audio_stop_sound(aGame); transitTo(gs.menu, menu);
				break;
			}
			break;
		}
		snd(aSelect);
	}
	if(ds_map_find_value(global.inputs2, vk_escape) && parent[gameState] != -1) {
		goBack();
		snd(aSelect);
	}
}
clearPressed();