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
