draw_set_font(fTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);

draw_text(room_width/2, 
	wave(190, 210, 2, 0, time), 
	titles[global.gameState]);

draw_set_font(fMain);
switch(global.gameState)
{
	case gs.menu:
	var names = ds_map_find_value(oPersistent.buttonNames, gs.menu);
	for(var i = 0; i < 4; i++)
	{
		draw_set_colour(row == i ? c_yellow : c_white);
		draw_text(room_width/2, 500 + i*120, names[i][0]);
	}
	break;
	case gs.select:
	break;
	case gs.options:
	break;
}