//for any object, this returns the bounding box id in which it resides
function getBoundingBoxID() {
    for(var i = 0; i < len(oGame.boundaries); i++) {
    	if(x >= oGame.boundaries[i][0] && x <= oGame.boundaries[i][2] &&
    		y >= oGame.boundaries[i][1] && y <= oGame.boundaries[i][3]) return i;
    }
    return -1;
}