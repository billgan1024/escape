function handleMouseActions() {
    //handle mouse events (again, only if canInteract is true)
    var hover = false;
    with(oButton) {
    	if(other.canInteract && !disabled && mouseOver(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset)) {
    		scale = smoothApproach(scale, 1, 0.3, 0.005);
    		hover = true;
    		if(other.input[1][in.mbLeft]) {
    			//instantly snap the cursor onto the clicked element so that any interaction will update
    			//cur, which will represent the clicked element
    			if(willMoveCursor) { 
    			    //update the row + col on mouse click only if the element doesn't take up the entire space
    			    if(r != span) other.r = r; 
    			    if(c != span) other.c = c; 
    			    other.cur = id;
    			}
    			//perform the update as usual and update the selector to match the clicked element and any 
    			//changes in the width/height that might have occured
    			snd(aSelect);
    			if(!is_undefined(enter)) {
        			with(other) { script_execute_ext(other.enter[0], other.enter[1]); clearInput(); }
    			}
    		}
    	}
    	else scale = smoothApproach(scale, baseScale, 0.3, 0.005);
    }
    
    //clicking logic for textboxes
    //note: when the window isn't focused, mouse presses are not even registered so it's fine if
    //persistent logic runs all the time.
    if(input[1][in.mbLeft]) {
        //log("hi");
        var selectedOne = false;
        with(oTextBox) {
            if(mouseOver(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset)) {
                selected = true; selectedOne = true; keyboard_string = text;
            } else selected = false;
        }
        if(selectedOne) keyboard_unset_map(); else bindInput();
    }
    
    if(menuData[gameState] == undefined) window_set_cursor(cr_none);
    else window_set_cursor(hover ? cr_drag : cr_default);
}