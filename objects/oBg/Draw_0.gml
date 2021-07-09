draw_sprite_ext(sBg, 0, vx, vy, 2560/1440, 1, 0, c_white, 1);
if(drawBg) {
    draw_sprite_ext(sBg2, 0, vx+offset, vy, 1, 1, 0, c_black, room == menu ? alpha*1.5 : alpha);
    draw_sprite_ext(sBg2, 0, vx+1920+offset, vy, 1, 1, 0, c_black, room == menu ? alpha*1.5 : alpha);
    draw_sprite_ext(sBg2, 0, vx-1920+offset, vy, 1, 1, 0, c_black, room == menu ? alpha*1.5 : alpha);
}