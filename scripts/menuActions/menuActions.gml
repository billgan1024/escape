//general purpose transition function that switches gamestate or the current room with a transition 
//specify landing coordinates as well (leave blank for (0, 0))
//leave newSong blank for no change in song, or set newSong = -1 to stop the current song
/// @param newState
/// @param [newRow=0] (set r, c = -1 for the previous row + column; this stack is cleared whenever the room changes/is restarted)
/// @param [newCol=0]
/// @param [newRoom] (leave blank or -1 for no change in room or -2 for restarting the current room)
/// @param [newSong] (leave blank to avoid switching the song, or -1 to stop playing the song) 
function transitionTo() {
	var newState = argument0;
	var newRow = 0, newCol = 0; if(argument_count >= 3) { newRow = argument1; newCol = argument2; } 
	
	if(newRow == -1 && newCol == -1) {
		tr = ds_stack_pop(pr); tc = ds_stack_pop(pc); 
	} else { 
		ds_stack_push(pr, r); ds_stack_push(pc, c); tr = newRow; tc = newCol; 
	}
	
	canInteract = false; snap = true; 
	
	newRoom = -1; if(argument_count >= 4) newRoom = argument3;
	//set newRoom if you want to trigger room_goto(), which resets everything.
	if(newRoom == -1) {
		state = 1; destState = newState;
	} else {
		//every new room transition will automatically clear the previous row/col stack 
		state = 3; destState = newState; 
		if(newRoom == -2) destRoom = room; else destRoom = newRoom;
		ds_stack_clear(pr); ds_stack_clear(pc);
	}
	if(argument_count == 5) {
		var newSong = argument4;
		stopMusic(); if(newSong != -1) destSong = newSong;
	}
}

//teleport to a new state without transition e.g. going from gs.game to gs.paused
//this will also clear the history
function teleportTo(newState) {
	r = 0; c = 0; ds_stack_clear(pr); ds_stack_clear(pc); 
	canInteract = false; snap = true; a[4] = inputDelay;
	with(oMenuItem) instance_destroy();
	gameState = newState; loadMenu(gameState);
}

function changeCursor(dr, dc) {
	//log(object_get_name(object_index));
	r = (r+dr+maxRow[gameState]) % maxRow[gameState];
	c = (c+dc+maxCol[gameState]) % maxCol[gameState];	
	checkSelected();
}

function changeText(newText) {
	cur.text = newText; 
	cur.w = string_width(newText); cur.h = string_height(newText); 
	updateSelectorTo(cur.x, cur.y, cur.w, cur.h);
}