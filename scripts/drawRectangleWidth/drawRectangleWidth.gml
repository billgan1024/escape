function drawRectangleWidth(x1, y1, x2, y2, w, a)
{
	if(w == 0) return;
	draw_sprite_ext(sWhite, 0, x1, y1, w, y2-y1+1, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x2-w+1, y1, w, y2-y1+1, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x1+w, y1, x2-x1-2*w+1, w, 0, c_white, a);
	draw_sprite_ext(sWhite, 0, x1+w, y2-w+1, x2-x1-2*w+1, w, 0, c_white, a);
	
}