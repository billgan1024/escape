draw_set_font(fMain);
draw_set_colour(c_white); 
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(vx+10, vy+vh, "Level " + string(lvl));

draw_set_halign(fa_right);

if(oPersistent.data[?"timer"]) draw_text(vx+vw-10, vy+vh, "Time: " + string(t) + "s");
else draw_text(vx+vw-10, vy+vh, "Attempt " + string(oPersistent.attempts));

draw_set_alpha(0.1);
draw_rectangle_width(vx, vy, vx+vw, vy+vh, borderRadius);
draw_set_alpha(1);

//draw the boundary at the appropriate depth
