function handleTransition() {
    switch(state) {
    	case 1: 
    	alpha = approach(alpha, 0, fadeSpeed);
    	if(alpha == 0) {
    		//destroy all items and load the new gameState
    		//also update array tracking menu item IDs
    		//make the cursor snap 
    		snap = true;
    		clearMenu(); 
    		//load the dest state (also updates the current gamestate)
    		loadMenu(destState);
    		changeCursor(tr, tc, true);
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
    		clearMenu();
    		room_goto(destRoom); 
    		loadMenu(destState);
    		changeCursor(tr, tc, true);
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
    	
    	case 5:
    	sAlpha = approach(sAlpha, 0, fadeSpeed);
    	if(sAlpha == 0) {
    	    snap = true;
    	    script_execute_ext(transitionFunction[0], transitionFunction[1]); 
    	    if(!is_undefined(tr) && !is_undefined(tc)) changeCursor(tr, tc, true);
    	    state++;
    	}
    	break;
    	
    	case 6:
    	sAlpha = approach(sAlpha, 1, fadeSpeed);
    	if(sAlpha == 1) { state = 0; canInteract = true; snap = false; }
    	break;
    }
}