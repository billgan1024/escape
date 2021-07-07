function inBoundary() {
    return x >= oGame.leftBoundary-sprite_width/2-60 && x <= oGame.rightBoundary+vw+sprite_width/2+60 
    && y >= oGame.yLevel*vh-sprite_height/2-60 && y <= oGame.yLevel*vh+vh+sprite_height/2+60; 
}