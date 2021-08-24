//draw a border based on the game's current boundary
with(oGame) {
	if(!is_undefined(boundingBox)) {
		var width = boundingBox[2]-boundingBox[0], height = boundingBox[3]-boundingBox[1];
		//horizontal borders
		draw_sprite_stretched(sDoor, 0, boundingBox[0]-60, boundingBox[1]-60, width+120, 60);
		draw_sprite_stretched(sDoor, 0, boundingBox[0]-60, boundingBox[3], width+120, 60);
		//vertical borders
		draw_sprite_stretched(sDoor, 0, boundingBox[0]-60, boundingBox[1], 60, height);
		draw_sprite_stretched(sDoor, 0, boundingBox[2], boundingBox[1], 60, height);
	}
}