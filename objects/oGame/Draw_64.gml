draw_set_font(fMain);
var str = "Level " + string_digits(room_get_name(room)); 
draw_set_colour(c_white); 
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(10, room_height-10, str);