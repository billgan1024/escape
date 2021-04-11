/// @description draw bullet glow
gpu_set_blendmode(bm_add);
with(oBullet) draw_sprite_ext(sSphere, 0, x, y, 1, 0.5, image_angle, c_aqua, 1);
gpu_set_blendmode(bm_normal);

with(oBullet) draw_self();