function handleTransition() {
    switch(state) {
    	case 1: 
    	alpha = approach(alpha, 0, fadeSpeed);
    	if(alpha == 0) {
    		//destroy all items and load the new gameState
    		//also update array tracking menu item IDs
    		snap = true;
    		with(oMenuItem) instance_destroy();
    		ds_grid_clear(itemIDs, 0); cur = undefined; 
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
    		ds_grid_clear(itemIDs, 0); cur = undefined;
    		gameState = destState; r = tr; c = tc; loadMenu(gameState); 
    		part_particles_clear(global.ps_above);
    		part_particles_clear(global.ps_below);
    		part_particles_clear(global.ps_bg);
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
}