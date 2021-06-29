//check for irregular placement of ground blocks lol
if(image_angle != 0 || frac(image_xscale) != 0 || frac(image_yscale) != 0 || x%60 != 0 || y%60 != 0
|| image_xscale <= 0 || image_yscale <= 0) {
    log(oGame.lvl, x, y);
}