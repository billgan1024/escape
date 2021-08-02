function drawMenu() {
    //draw paused tint
    if(gameState == gs.paused || gameState == gs.optionsGame) draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, 0.6);
    dsfont(fTitle); dsalpha(alpha);
    //background items support 
    //if(!is_undefined(backgroundItems[gameState])) script_execute_ext(backgroundItems[gameState][0], backgroundItems[gameState][1]);
    
    draw_text(vx+vw/2, vy+wave(195, 205, 2.5, t), titles[gameState]);
    
    dsfont(fSmall);
    dshalign(fa_left); dsvalign(fa_bottom); draw_text(vx+10, vy+vh+6, bottomLeft[gameState]);
    dshalign(fa_right); draw_text(vx+vw-10, vy+vh+6, bottomRight[gameState]);
    dshalign(fa_center); dsvalign(fa_middle);
    dsfont(fMain);
    
    with(oButton) {
    	if(spr != undefined) draw_sprite_ext(spr, imageIndex, vx+x, vy+y, overallScale, overallScale, 0, c_white, 
    	    overallAlpha); 
    	else {
    	    //draw the button with all of the draw values computed in the step event
    	    draw_text_transformed_color(vx+x, vy+y, text, overallScale, overallScale, 0,
    	        c_white, c_white, c_white, c_white, overallAlpha);
    	}
    }
    
    //note: for now, there is no custom scale factor for textboxes. feel free to implement it later.
    
    with(oTextBox) {
        draw_sprite_ext(sWhite, 0, vx+x-w/2, vy+y-h/2, w, h-vOffset, 0, c_black, other.alpha/5);
        dsfont(fSmall); dsvalign(fa_bottom);
        draw_text(vx+x, vy+y-h/2, label);
        dsfont(fMain); dsvalign(fa_middle);
        //actual text to draw
        //for password fields, replace the text with *
        
        //draw the text with a constant relative scale of 0.8 (always make it slightly smaller than the main scale)
        //also change its scale if the text width is too big
        //NOTE: for a textbox, allow a padding of 30 on both sides; therefore, the effective width
        //is w-60
        draw_text_transformed(vx+x, vy+y, drawText, mainTextBoxScale*flexScale, mainTextBoxScale*flexScale, 0);
        
        //draw the textbox cursor if it's selected
        //because there's no custom scale factor, simply set arbitrary values for the rectangle size
        if(selected && textCursor) {
            draw_sprite_ext(sWhite, 0, vx+x+string_width(drawText)*mainTextBoxScale*flexScale/2+(string_length(drawText) > 0 ? 3 : 0), 
            vy+y-h/2+(h-vOffset-60)/2, 3, 60, 0, c_white, other.alpha/5);
        }
        
        //textbox edges (note that the outermost rectangle has width = w)
    	drawRectangleWidth(vx+x-w/2, vy+y-h/2, vx+x+w/2, vy+y+h/2-vOffset, 2, other.alpha/2);
    	drawRectangleWidth(vx+x-w/2+4, vy+y-h/2+4, vx+x+w/2-4, vy+y+h/2-4-vOffset, 2, other.alpha/2);
    }
    //draw selector rectangle if you're not in game
    if(gameState != gs.game) {
    	//selectorFrom[] = [x, y, w, h]
    	//x, y is the center position of the text
    	var sx = selector[0], sy = selector[1], sw = selector[2], sh = selector[3];
    	var xx = vx+sx-sw/2, yy = vy+sy-sh/2;
    	//also make the selector affected by in-state transition alpha changes
    	//the selector will only dim if it is in the transition area
    	drawRectangleWidth(xx, yy, xx+sw, yy+sh-vOffset, 4, alpha/5*(r >= tr1 && r <= tr2 && c >= tc1 && c <= tc2 ? sAlpha : 1));
    }
    
    //draw transition tint if we're switching rooms
    draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, tAlpha);
    
    //reset to default font settings (note that in the draw code, all deviations from the default
    //settings are resolved as soon as possible)
    dsalpha(1);
}