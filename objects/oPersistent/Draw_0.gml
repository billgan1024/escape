//draw paused tint
if(gameState == gs.paused || gameState == gs.optionsGame) draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, 0.6);
dsfont(fTitle); dsalpha(alpha);
draw_text(vx+vw/2, vy+wave(195, 205, 2.5, t), titles[gameState]);
dsfont(fSmall);
dshalign(fa_left); dsvalign(fa_bottom); draw_text(vx+10, vy+vh+6, bottomLeft[gameState]);
dshalign(fa_right); draw_text(vx+vw-10, vy+vh+6, bottomRight[gameState]);
dshalign(fa_center); dsvalign(fa_middle);
dsfont(fMain);
with(oButton) {
	if(spr != undefined) draw_sprite_ext(spr, imageIndex, vx+x, vy+y, scale, scale, 0, c_white, other.alpha); 
	else draw_text_transformed(vx+x, vy+y, text, scale, scale, 0);
}
with(oTextBox) draw_rectangle_width(vx+x-80, vy+y-20, vx+x+80, vy+y+20, 3);
//draw selector rectangle if you're not in game
if(gameState != gs.game) {
	//selectorFrom[] = [x, y, w, h]
	//x, y is the center position of the text
	var sx = selectorFrom[0], sy = selectorFrom[1], sw = selectorFrom[2], sh = selectorFrom[3];
	var xx = vx+sx-sw/2, yy = vy+sy-sh/2;
	dsalpha(alpha/5);
	draw_rectangle_width(xx, yy, xx+sw, yy+sh-vOffset, 3);
}

//draw transition tint if we're switching rooms
draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, tAlpha);

//reset to default font settings (note that in the draw code, all deviations from the default
//settings are resolved as soon as possible)
dsalpha(1);