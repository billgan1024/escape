//draw paused tint
if(gameState == gs.paused || gameState == gs.optionsGame) draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, 0.6);
//draw the title based on the gameState
dsfont(fTitle); dsalpha(alpha);
draw_text(vx+vw/2, vy+wave(195, 205, 2.5, t), titles[gameState]);
dsfont(fMain);
//draw_text(100, 100, a[2]);
switch(gameState) {
	case gs.username:
	break;
	
	case gs.menu:
	var by = 500;
	for(var i = 0; i < 4; i++) {
		draw_text(vx+vw/2, vy+by+i*120, menuTitles[i]);
		if(r == i) {
			//update the selector location and size while checking if you should snap the selector
			updateSelectorTo(vw/2, by+i*120, string_width(menuTitles[i]), string_height(menuTitles[i]));
		}
	}
	dshalign(fa_left); dsvalign(fa_bottom);
	draw_text(vx+10, vy+vh+6, "Bill Gan");
	dshalign(fa_right); dsfont(fSmall);
	draw_text(vx+vw-10, vy+vh+6, navigationHelp);
	dsfont(fMain); dshalign(fa_center); dsvalign(fa_center);
	break;
	
	case gs.select:
	var bx = vw/2-120*3.5, by = 400;
	for(var i = 0; i < 4; i++) {
		for(var j = 0; j < 8; j++) {
			lvl = 8*i+j+1;
			draw_text(vx+bx+j*120, vy+by+i*120, lvl);
			if(r == i && c == j) {
				updateSelectorTo(bx+j*120, by+i*120, string_width(string(lvl)), string_height(string(lvl)));
			}
			//check when you have reached the number of levels you unlocked
			if(lvl == ds_map_find_value(data, "lvl")) dsalpha(alpha/5);
		}
	}
	dsalpha(alpha);
	draw_text(vx+vw/2, vy+by+7*120, "Back");
	if(r == 4) {
		updateSelectorTo(vw/2, by+7*120, string_width(string("Back")), string_height(string("Back"))); 
	}
	break;

	//options and game options are the same menu
	case gs.options:
	case gs.optionsGame:
	var by = 400;
	for(var i = 0; i < 5; i++) {
		var str = "";
		switch(i) {	
			case 0: str = "Sound FX: " + string(ds_map_find_value(data, "sfx")) + "%";
			break;
			case 1: str = "Music: " + string(ds_map_find_value(data, "mus")) + "%";
			break;
			case 2: str = "Fullscreen: " + (ds_map_find_value(data, "fs") ? "On" : "Off");
			break;
			case 3: str = "Timer: " + (ds_map_find_value(data, "timer") ? "On" : "Off");
			break;
			case 4: str = "Toggle Sprint: " + (ds_map_find_value(data, "toggle-sprint") ? "On" : "Off");
			break;
			//add controls later
			/*case 4: str = "Controls";
			break;*/
		}
		draw_text(vx+vw/2, vy+by+i*120, str);
		if(r == i) {
			updateSelectorTo(vw/2, by+i*120, string_width(str), string_height(str));
		}
	}
	draw_text(vx+vw/2, vy+by+7*120, "Back");
	if(r == 5) {
		updateSelectorTo(vw/2, by+7*120, string_width(string("Back")), string_height(string("Back"))); 
	}
	break;
	
	case gs.paused:
	var by = 500;
	for(var i = 0; i < 4; i++) {
		draw_text(vx+vw/2, vy+by+i*120, pauseTitles[i]);
		if(r == i) {
			updateSelectorTo(vw/2, by+i*120, string_width(pauseTitles[i]), string_height(pauseTitles[i]));
		}
	}
	break;
}
//draw selector rectangle if you're not in game
if(gameState != gs.game) {
	var sx = selectorFrom[0], sy = selectorFrom[1], sw = selectorFrom[2], sh = selectorFrom[3];
	var xx = vx+sx-sw/2, yy = vy+sy-sh/2;
	dsalpha(alpha/5);
	draw_rectangle_width(xx, yy, xx+sw, yy+sh-5, 3);
}

//draw transition tint if we're switching rooms
draw_sprite_ext(sBlack, 0, vx, vy, vw, vh, 0, c_white, tAlpha);

//reset to default font settings (note that in the draw code, all deviations from the default
//settings are resolved as soon as possible)
dsalpha(1);