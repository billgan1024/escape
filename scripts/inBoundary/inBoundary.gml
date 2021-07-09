function inBoundary() {
    //allow leeway for bullets to disappear naturally
    return x >= oGame.leftBoundary-sprite_width/2-120 && x <= oGame.rightBoundary+vw+sprite_width/2+120 
    && y >= oGame.yLevel*vh-sprite_height/2-120 && y <= oGame.yLevel*vh+vh+sprite_height/2+120; 
}