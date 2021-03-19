gpu_set_blendmode(bm_add);
draw_sprite_ext(sSphere, 0, x, y, 1, 1, 0, c_green, 1);
gpu_set_blendmode(bm_normal);
draw_self();