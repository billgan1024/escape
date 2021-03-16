//draw the title based on the gameState
dshalign(fa_center); dsvalign(fa_middle); dscolour(c_white); dsfont(fTitle); dsalpha(alpha);
draw_text(vx+vw/2, vy+wave(195, 205, 2, 0, t), titles[gameState]);

dsfont(fMain);
switch(gameState) {
	case gs.menu:
	var by = 500;
	for(var i = 0; i < 4; i++) {
		draw_text(vx+vw/2, vy+by+i*120, menuTitles[i]);
		if(r == i) {
			//update the selector location and size while checking if you should snap the selector
			updateSelectorTo(vw/2, by+i*120, string_width(menuTitles[i]), string_height(menuTitles[i]));
		}
	}
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
		}
	}
	draw_text(vx+vw/2, vy+by+7*120, "Back");
	if(r == 4) {
		updateSelectorTo(vw/2, by+7*120, string_width(string("Back")), string_height(string("Back"))); 
	}
	break;

	//options and game options are the same menu
	case gs.options:
	case gs.optionsGame:
	var by = 400;
	for(var i = 0; i < 4; i++) {
		var str = "";
		switch(i+1) {	
			case 1: str = "Sound: " + string(ds_map_find_value(data, "sfx")) + "%";
			break;
			case 2: str = "Music: " + string(ds_map_find_value(data, "mus")) + "%";
			break;
			case 3: str = "Fullscreen: " + (ds_map_find_value(data, "fs") ? "On" : "Off");
			break;
			case 4: str = "Timer: " + (ds_map_find_value(data, "timer") ? "On" : "Off");
			break;
			case 5: str = "Controls";
			break;
		}
		draw_text(vx+vw/2, vy+by+i*120, str);
		if(r == i) {
			updateSelectorTo(vw/2, by+i*120, string_width(str), string_height(str));
		}
	}
	draw_text(vx+vw/2, vy+by+7*120, "Back");
	if(r == 4) {
		updateSelectorTo(vw/2, by+7*120, string_width(string("Back")), string_height(string("Back"))); 
	}
	break;
	
	case gs.game:
	dshalign(fa_left); dsvalign(fa_bottom);
	draw_text(vx+10, vy+vh-10, string_digits(room_get_name(room)));
	break;
}
//draw selector rectangle
var sx = selectorFrom.xpos, sy = selectorFrom.ypos;
var sw = selectorFrom.w, sh = selectorFrom.h;
var xx = vx+sx-sw/2, yy = vy+sy-sh/2;
dsalpha(alpha/5);
draw_rectangle_width(xx, yy, xx+sw, yy+sh, 3);
dsalpha(1);