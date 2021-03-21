/// @description step event
t += 1/240;

updateSelector();
show_debug_message(keyboard_lastkey);
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
		part_system_clear(global.ps_above);
		part_system_clear(global.ps_below);
		part_system_depth(global.ps_above, layer_get_depth("Above"));
		part_system_depth(global.ps_below, layer_get_depth("Below"));
		//swap songs only if you stopped the audio in the transition menu -> game
		if(gameState == gs.game && !audio_is_playing(aGame)) mus(aGame);
		else if(gameState == gs.menu && !audio_is_playing(aMenu)) mus(aMenu);
		state++;
	}
	break;
	case 4: 
	tAlpha = approach(tAlpha, 0, fadeSpeed);
	if(tAlpha == 0) { state = 0; canInteract = true; snap = false; }
	break;
}

//handle pausing 
//handle menus
if(canInteract) {
	if(gameState == gs.game || gameState == gs.paused) {
		if(input2[in.esc]) {
			if(gameState == gs.game) { 
				gameState = gs.paused; snd(aPause); r = 0; c = 0;
				canInteract = false; snap = true; a[4] = inputDelay;
			}
			else gameState = gs.game;
			clearPressed();
		}
	}
	if(gameState != gs.game)
	{
		//menu navigation controls (only activate if state == 0 and the selector isn't moving)
		if(input2[in.down] || input2[in.keyS]) {
			r = (r+1) % row[gameState];
			canInteract = false; a[2] = inputDelay; 
			snd(aScroll); clearPressed();
		}
		if(input2[in.up] || input2[in.keyW]) {
			r = (r-1+row[gameState]) % row[gameState];
			canInteract = false; a[2] = inputDelay; 
			snd(aScroll); clearPressed();
		}
		if((input2[in.right] || input2[in.keyD]) && horizontal) {
			if((gameState == gs.options || gameState == gs.optionsGame) && (r == 0 || r == 1)) {
				if(r == 0) {
					//update sound
					data[?"sfx"] = min(100, data[?"sfx"]+10);
					updateSoundVol();
					save();
				} else {
					//update music
					data[?"mus"] = min(100, data[?"mus"]+10);
					updateMusicVol();
					save();
				}
				snd(aScroll); clearPressed();
			} else if(col[gameState] > 1) {
				c = (c+1) % col[gameState];
				canInteract = false; a[2] = inputDelay; 
				snd(aScroll); clearPressed();
			}
		}
		if((input2[in.left] || input2[in.keyA]) && horizontal) {
			if((gameState == gs.options || gameState == gs.optionsGame) && (r == 0 || r == 1)) {
				if(r == 0) {
					//update sound
					data[?"sfx"] = max(0, data[?"sfx"]-10);
					updateSoundVol();
					save();
				} else {
					//update music
					data[?"mus"] = max(0, data[?"mus"]-10);
					updateMusicVol();
					save();
				}
				snd(aScroll); clearPressed();
			} else if(col[gameState] > 1) {
				c = (c-1+col[gameState]) % col[gameState];
				canInteract = false; a[2] = inputDelay; 
				snd(aScroll); clearPressed();
			}
		}
		if(input2[in.enter]) {
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
					} else clearPressed(); 
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
							a[1] = 10; clearPressed();
						break;
					
						case 3:
						ds_map_replace(data, "timer", !ds_map_find_value(data, "timer"));
						save(); clearPressed();
						break;
					}
				}
				break;
				case gs.paused:
				switch(r) {
					case 0: gameState = gs.game; clearPressed();
					break;
					case 1: transitTo(gs.game, room);
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
		if(input2[in.esc] && parent[gameState] != -1) {
			snd(aSelect); goBack();
		}
	}
}
clearPressed();