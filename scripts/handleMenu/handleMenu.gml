function handleMenu() {
	//handle keyboard presses and mouse actions
	//pro tip: calling a function using id.f() will have the caller as that object
	//however, using script_execute(id.f) will have the caller as the original instance which called script_execute;
	//in this case, it's oPersistent
	
	//a key concept for this menu is to never allow the user to press two buttons in the same frame
	//this is done by completely wiping the input array after a function was successfully activated by an input
	
	if(input[1][in.left] && !is_undefined(cur.left)) { script_execute_ext(cur.left[0], cur.left[1]); snd(aScroll); clearInput(); }
	if(input[1][in.right] && !is_undefined(cur.right)) { script_execute_ext(cur.right[0], cur.right[1]); snd(aScroll); clearInput(); }
	if(input[1][in.up] && !is_undefined(cur.up)) { script_execute_ext(cur.up[0], cur.up[1]); snd(aScroll); clearInput(); }
	if(input[1][in.down] && !is_undefined(cur.down)) { script_execute_ext(cur.down[0], cur.down[1]); snd(aScroll); clearInput(); }
	if(input[1][in.enter] && !is_undefined(cur.enter) && !cur.disabled) { script_execute_ext(cur.enter[0], cur.enter[1]); snd(aSelect); clearInput(); }
	
    //handle mouse events (again, only if canInteract is true and reqImportant is false)
    with(oButton) {
    	if(!disabled && mouseOver(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset)) {
    		scale = smoothApproach(scale, 1, 0.3, 0.005);
    		other.hover = true;
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
    
    //check if the user clicked the notification
	if(!is_undefined(notifFunction[0]) && mouseOver(vx, vy+vh-100+bottom_offset, vx+vw, vy+vh)) {
		hover = true;
		if(input[1][in.mbLeft]) {
			snd(aSelect); script_execute_ext(notifFunction[0][0], notifFunction[0][1]); clearInput();
		}
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
                textCursor = true; a[1] = 120; 
            } else {
                selected = false; textCursor = false; a[1] = infinity;
            }
        }
        if(selectedOne) {
        	keyboard_unset_map(); 
        	clearInput();
        }
        else bindInput();
    }
    
    //scroll to the next textbox
    if(input[1][in.tab]) {
    	//find out the current selected textbox and change it to let the next textbox get selected
    	var s = ds_list_size(textboxIDs);
    	for(var i = 0; i < s; i++) {
    		if(textboxIDs[|i].selected) {
    			with(textboxIDs[|i]) { selected = false; textCursor = false; a[1] = infinity; }
    			with(textboxIDs[|(i+1)%s]) {
    				selected = true; keyboard_string = text;
	                textCursor = true; a[1] = 120; 
    			}
    			clearInput();
    			break;	
    		}
    	}
    }
}