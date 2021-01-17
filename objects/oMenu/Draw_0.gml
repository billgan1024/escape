draw_set_font(fTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);

draw_text(room_width/2, 
	wave(190, 210, 2, 0, time), 
	titles[global.gameState]);

draw_set_font(fMain);
draw_set_colour(c_white);
switch(global.gameState)
{
	case gs.menu:
	var names = ds_map_find_value(oPersistent.buttonNames, gs.menu);
	for(var i = 0; i < 4; i++)
	{
		var w = string_width(names[i][0]), h = string_height(names[i][0]);
		if(row == i) draw_rectangle(room_width/2-w/2-10, 500+i*120-h/2-5,
			room_width/2+w/2+10, 500+i*120+h/2+5, true);
		draw_text(room_width/2, 500+i*120, names[i][0]);
	}
	break;
	case gs.select:
	var names = ds_map_find_value(oPersistent.buttonNames, gs.select);
	for(var i = 0; i < 4; i++)
	{
		for(var j = 0; j < 4; j++)
		{
			var w = string_width(names[i][j]), h = string_height(names[i][j]);
		if(row == i && col == j) draw_rectangle(1100+j*120-w/2-10, 500+i*120-h/2-5,
			1100+j*120+w/2+10, 500+i*120+h/2+5, true);
			draw_text(1100 + j*120, 500 + i*120, names[i][j]);
		}
	}
	break;
	case gs.options:
	break;
}