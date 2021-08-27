draw_sprite_ext(sBg, 0, vx, vy, 2560/1440, 1, 0, c_white, 1);
if(drawBg) {
    //draw backgrounds with tiling (bg is 1920x1920)
    for(var i = -1; i <= 1; i++) {
        for(var j = -1; j <= 1; j++) {
            draw_sprite_ext(sBg2, 0, vx+offsetX+i*bgWidth, vy+offsetY+j*bgHeight, 1, 1, 0, c_black, alpha*(room == menu ? 1.5 : 1));
        }
    }
}