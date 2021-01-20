gpu_set_blendmode(bm_add);
draw_sprite_ext(sSphere, 0, x, y, 1, 0.5, image_angle, colour, 1);
gpu_set_blendmode(bm_normal);
draw_self();