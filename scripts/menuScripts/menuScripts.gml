function updateSelector() {
	for(var i = 0; i < 4; i++) selectorFrom[i] = smoothApproach(selectorFrom[i], selectorTo[i], snap ? 1 : 0.1); 
}

function updateSelectorTo() {
	for(var i = 0; i < 4; i++) selectorTo[i] = argument[i]; 
	selectorTo[2] += 20; selectorTo[3] += 6;
}

function checkSelected() {
	if(oPersistent.r == r && oPersistent.c == c) updateSelectorTo(x, y, w, h);
}

function draw_rectangle_width(x1, y1, x2, y2, w)
{
	if(w == 0) return;
	draw_rectangle(x1, y1, x1+w, y2, false);
	draw_rectangle(x2-w, y1, x2, y2, false);
	draw_rectangle(x1+(w+1), y1, x2-(w+1), y1+w, false);
	draw_rectangle(x1+(w+1), y2-w, x2-(w+1), y2, false);
}

function goBack() {
	state = 1; destState = parent[gameState]; tr = pr; tc = pc;
	canInteract = false; snap = true;	
}

function goForward(newState) {
	state = 1; destState = newState; tr = 0; tc = 0; pr = r; pc = c;
	canInteract = false; snap = true;	
}

function transitTo(newState, newRoom) {
	state = 3; destState = newState; destRoom = newRoom;
	tr = 0; tc = 0; pr = 0; pc = 0;
	canInteract = false; snap = true;
}

function handleMenu() {
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
		if(input2[in.down]) {
			r = (r+1) % row[gameState];
			snd(aScroll); clearPressed(); 
		}
		if(input2[in.up]) {
			r = (r-1+row[gameState]) % row[gameState];
			snd(aScroll); clearPressed();
		}
		//for horizontal menu keys, only play the sound & update if there's more than one column
		if(input2[in.right] && horizontal) {
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
				snd(aScroll); clearPressed();
			}
		}
		if(input2[in.left] && horizontal) {
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
				snd(aScroll); clearPressed();
			}
		}
		if(input2[in.enter]) {
			switch(gameState) {
				case gs.menu:
				switch(r) {
					//Note: this should warp to the max unlocked level
					case 0: audio_stop_sound(aMenu); transitTo(gs.game, level1); 
					resetAttempts = true;
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
						resetAttempts = true;
					} else clearPressed(); 
				}
				break;
				//options and optionsGame represent the same state
				case gs.options:
				case gs.optionsGame:
				if(r == 5) goBack(); 
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
						ds_map_replace(data, "timer", !data[?"timer"]);
						save(); clearPressed();
						break;
						
						case 4:
						ds_map_replace(data, "toggle-sprint", !data[?"toggle-sprint"]);
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

