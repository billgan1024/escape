var pixels = 60*(1-yscale)/2;
draw_sprite_ext(sPlayer, 0, x, y+pixels, image_xscale, yscale, 0, c_white, image_alpha);
draw_text(x, y-50, state);
//if(abs(hsp) > runSpd*11/12) draw_text(x, y-50, "run");
//note: u will never fall off a platform
/*var g = instance_place(x, y+1, oHorizontalPlatform);
if(g != noone) draw_text(x, y-50, x-g.x);*/