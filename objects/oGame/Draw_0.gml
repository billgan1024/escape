draw_set_font(fMain);
draw_set_colour(c_white); 
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(vx+10, vy+room_height-10, "Level " + string(lvl));

//draw the glow of every object that needs it
gpu_set_blendmode(bm_add);
with(oCoin) { draw_sprite_ext(sSphere, 0, x, y, 0.4, 0.4, 0, c_yellow, 1); }
with(oGem) { draw_sprite_ext(sSphere, 0, x, y, 1, 1, 0, c_green, 1); }
gpu_set_blendmode(bm_normal);

with(oCoin) draw_self();
with(oGem) draw_self();