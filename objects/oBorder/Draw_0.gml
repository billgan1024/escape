//draw a border based on the game's current boundary
with(oGame) {
	//horizontal borders
	draw_sprite_stretched(sDoor, 0, -60, -60, room_width+120, 60);
	draw_sprite_stretched(sDoor, 0, -60, room_height, room_width+120, 60);
	//vertical borders
	draw_sprite_stretched(sDoor, 0, -60, 0, 60, room_height);
	draw_sprite_stretched(sDoor, 0, room_width, 0, 60, room_height);
}