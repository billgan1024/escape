t += 1/240;
updateSelector();
//update whether horizontal controls are allowed
horizontal = !((gameState == gs.select && r == 4));
switch(state) {
	case 1: alpha = approach(alpha, 0, fadeSpeed);
	if(alpha == 0) {
		//swap game states
		gameState = destState; r = tr; c = tc;
		state++;
	}
	break;
	case 2: alpha = approach(alpha, 1, fadeSpeed);
	if(alpha == 1) { state = 0; snap = false; }
	break;
}
//menu navigation controls (only activate if state == 0 
//and the selector isn't moving)
if(canInteract)
{
	if(ds_map_find_value(global.inputs2, vk_down) || ds_map_find_value(global.inputs2, ord("S"))) {
		r = (r+1) % row[gameState];
		canInteract = false; a[2] = inputDelay; 
	}
	if(ds_map_find_value(global.inputs2, vk_up) || ds_map_find_value(global.inputs2, ord("W"))) {
		r = (r-1+row[gameState]) % row[gameState];
		canInteract = false; a[2] = inputDelay; 
	}
	if((ds_map_find_value(global.inputs2, vk_right) || ds_map_find_value(global.inputs2, ord("D"))) && horizontal) {
		if(gameState == gs.options && (r == 0 || r == 1)) {
			if(r == 0) {
				//update sound
				ds_map_replace(data, "sfx", min(100, ds_map_find_value(data, "sfx")+10));
				ds_map_secure_save(data, fileName);
			} else {
				//update music
				ds_map_replace(data, "mus", min(100, ds_map_find_value(data, "mus")+10));
				ds_map_secure_save(data, fileName);
			}
			
		} else {
			c = (c+1) % col[gameState];
			canInteract = false; a[2] = inputDelay; 
		}
	}
	if((ds_map_find_value(global.inputs2, vk_left) || ds_map_find_value(global.inputs2, ord("A"))) && horizontal) {
		if(gameState == gs.options && (r == 0 || r == 1)) {
			if(r == 0) {
				//update sound
				ds_map_replace(data, "sfx", max(0, ds_map_find_value(data, "sfx")-10));
				ds_map_secure_save(data, fileName);
			} else {
				//update music
				ds_map_replace(data, "mus", max(0, ds_map_find_value(data, "mus")-10));
				ds_map_secure_save(data, fileName);
			}
			
		} else {
			c = (c-1+col[gameState]) % col[gameState];
			canInteract = false; a[2] = inputDelay; 
		}
	}
	if(ds_map_find_value(global.inputs2, vk_enter)) {
		switch(gameState) {
			case gs.menu:
			switch(r) {
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
				//go to a particular level	
			}
			break;
			case gs.options:
			if(r == 4) goBack(); 
			else {
				switch(r) {
					case 2:
						window_set_fullscreen(!window_get_fullscreen());
						ds_map_replace(data, "fs", window_get_fullscreen());
						ds_map_secure_save(data, fileName);
						window_set_size(h/3*4, h/4*3);
						a[1] = 10;
					break;
					
					case 3:
					ds_map_replace(data, "timer", !ds_map_find_value(data, "timer"));
					ds_map_secure_save(data, fileName);
					break;
				}
			}
			break;
		}
	}
	if(ds_map_find_value(global.inputs2, vk_escape) && parent[gameState] != -1) {
		goBack();
	}
}
clearPressed();