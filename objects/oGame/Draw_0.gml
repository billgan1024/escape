draw_set_font(fMain);
draw_set_colour(c_white); 
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(vx+10, vy+room_height-10, lvlName);

//draw the glow of every object which needs it
gpu_set_blendmode(bm_add);

gpu_set_blendmode(bm_normal);