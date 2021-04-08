draw_set_font(fMain);
draw_set_colour(c_white); 
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(vx+10, vy+vh-8, "Level " + string(lvl));

draw_set_halign(fa_right);
draw_text(vx+vw-10, vy+vh-8, "Attempt " + string(oPersistent.attempts));