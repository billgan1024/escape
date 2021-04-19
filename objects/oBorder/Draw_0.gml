//draw a border based on the game's current boundary
with(oGame) {
	if(yLevel != -1) {
		var yy = yLevel*vh, width = rightBoundary-leftBoundary+vw;
		//horizontal borders
		draw_sprite_stretched(sGround, 0, leftBoundary-60, yy-60, width+120, 60);
		draw_sprite_stretched(sGround, 0, leftBoundary-60, yy+vh, width+120, 60);
		//vertical borders
		draw_sprite_stretched(sGround, 0, leftBoundary-60, yy, 60, vh);
		draw_sprite_stretched(sGround, 0, rightBoundary+vw, yy, 60, vh);
	}
}