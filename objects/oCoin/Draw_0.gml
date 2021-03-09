gpu_set_blendmode(bm_add);
draw_sprite_ext(sSphere, 0, x, y, 0.5, 0.5, 0, c_yellow, 1);
gpu_set_blendmode(bm_normal);
draw_self();