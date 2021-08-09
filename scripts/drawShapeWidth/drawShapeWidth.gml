//all of these functions draw rectangles from pixel (x1, y1) to (x2, y2) inclusive
function drawRectangleWidth(x1, y1, x2, y2, w, a)
{
	if(w > 0) {
		draw_sprite_ext(sWhite, 0, x1, y1, w, y2-y1+1, 0, c_white, a);
		draw_sprite_ext(sWhite, 0, x2-w+1, y1, w, y2-y1+1, 0, c_white, a);
		draw_sprite_ext(sWhite, 0, x1+w, y1, x2-x1-2*w+1, w, 0, c_white, a);
		draw_sprite_ext(sWhite, 0, x1+w, y2-w+1, x2-x1-2*w+1, w, 0, c_white, a);
	}
}

//edit: simply use the nine slicing technique
//for reference, the target width is always 4 and 'corner size' (in paint.net) was set to 6
function drawRoundedRectWidth(x1, y1, x2, y2, a) {
	//nine slice (the corners enclose (x1, y1) to (x2, y2) inclusive with rotation being kept in mind)
	//you need to add 1 since our origin is the top left corner, so the entire image is being flipped around that point
	draw_sprite_ext(sSelectorCorner, 0, x1, y1, 1, 1, 0, c_white, a);
	draw_sprite_ext(sSelectorCorner, 0, x2+1, y1, -1, 1, 0, c_white, a);
	draw_sprite_ext(sSelectorCorner, 0, x1, y2+1, 1, -1, 0, c_white, a);
	draw_sprite_ext(sSelectorCorner, 0, x2+1, y2+1, -1, -1, 0, c_white, a);
	
	//horizontal
	draw_sprite_ext(sWhite, 0, x1+8, y1, x2-x1-2*8+1, 4, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x1+8, y2-4+1, x2-x1-2*8+1, 4, 0, c_white, a);
	
	//vertical
	draw_sprite_ext(sWhite, 0, x1, y1+8, 4, y2-y1-2*8+1, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x2-4+1, y1+8, 4, y2-y1-2*8+1, 0, c_white, a);
}
