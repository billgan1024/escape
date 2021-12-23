var pixels = 60*(1-yscale)/2;
draw_sprite_ext(sPlayer, 0, x, y+pixels, image_xscale, yscale, 0, c_white, image_alpha);
//draw_text(x, y-50, state);
//draw_text(x, y-100, platform);	
// draw_rectangle_color(x+hsp_frac-30, y+vsp_frac-30, x+hsp_frac+30, y+vsp_frac+30, c_red, c_red, c_red, c_red, true);
// if(abs(hsp) > runSpd*11/12) draw_text(x, y-50, "run");
//note: u will never fall off a platform
