function drawMenu() {
    //draw paused tint
    if(gameState == gs.paused || gameState == gs.optionsGame) draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, 0.6);
    dsfont(fTitle); dsalpha(alpha);
    
    if(!is_undefined(backgroundItems[gameState])) script_execute_ext(backgroundItems[gameState][0], backgroundItems[gameState][1]);
    
    draw_text(vx+vw/2, vy+wave(195, 205, 2.5, t), titles[gameState]);
    
    dsfont(fSmall);
    dshalign(fa_left); dsvalign(fa_bottom); draw_text(vx+10, vy+vh+6, bottomLeft[gameState]);
    dshalign(fa_right); draw_text(vx+vw-10, vy+vh+6, bottomRight[gameState]);
    dshalign(fa_center); dsvalign(fa_middle);
    dsfont(fMain);
    
    with(oButton) {
    	if(spr != undefined) draw_sprite_ext(spr, imageIndex, vx+x, vy+y, scale*customScale, scale*customScale, 0, c_white,
    	other.alpha*alphaScale); 
    	else {
        	dsalpha(other.alpha*alphaScale*(r >= other.tr1 && r <= other.tr2 && c >= other.tc1 && c <= other.tc2 ? other.sAlpha : 1));
        	var adjustScale = min(maxWidth/string_width(text), 1);
    	    draw_text_transformed(vx+x, vy+y, text, scale*adjustScale*customScale, scale*adjustScale*customScale, 0);
    	    dsalpha(other.alpha);
    	}
    }
    with(oTextBox) draw_text(vx+x, vy+y, text);
    with(oTextBox) {
    	drawRectangleWidth(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset, 2, other.alpha/2);
    	drawRectangleWidth(vx+x-w/2+4, vy+y-h/2+4, vx+x+w/2-4, vy+y+h/2-4-vOffset, 2, other.alpha/2);
    }
    //draw selector rectangle if you're not in game
    if(gameState != gs.game) {
    	//selectorFrom[] = [x, y, w, h]
    	//x, y is the center position of the text
    	var sx = selector[0], sy = selector[1], sw = selector[2], sh = selector[3];
    	var xx = vx+sx-sw/2, yy = vy+sy-sh/2;
    	drawRectangleWidth(xx, yy, xx+sw, yy+sh-vOffset, 4, alpha/5);
    }
    
    //draw transition tint if we're switching rooms
    draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, tAlpha);
    
    //reset to default font settings (note that in the draw code, all deviations from the default
    //settings are resolved as soon as possible)
    dsalpha(1);
}