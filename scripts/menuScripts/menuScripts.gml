function updateSelector() {
	selectorFrom.xpos = smoothApproach(selectorFrom.xpos, selectorTo.xpos, 0.1, 1);
	selectorFrom.ypos = smoothApproach(selectorFrom.ypos, selectorTo.ypos, 0.1, 1);
	selectorFrom.w = smoothApproach(selectorFrom.w, selectorTo.w, 0.1, 1);
	selectorFrom.h = smoothApproach(selectorFrom.h, selectorTo.h, 0.1, 1);
}

function updateSelectorTo(nx, ny, nw, nh) {
	selectorTo.xpos = nx;
	selectorTo.ypos = ny;
	selectorTo.w = nw+20;
	selectorTo.h = nh+6;
	if(snap) {
		selectorFrom.xpos = selectorTo.xpos;
		selectorFrom.ypos = selectorTo.ypos;
		selectorFrom.w = selectorTo.w;
		selectorFrom.h = selectorTo.h;
	}
}
function draw_rectangle_width(x1, y1, x2, y2, w)
{
	draw_line_width(x1, y1, x2, y1, w);
	draw_line_width(x2, y1, x2, y2, w);
	draw_line_width(x1, y2, x2, y2, w);
	draw_line_width(x1, y1, x1, y2, w);
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

