function inBoundary() {
    //allow leeway for bullets to disappear naturally
    var leeway = 120;
    return x >= oGame.boundaries[roomID][0]-leeway && x <= oGame.boundaries[roomID][2]+leeway 
    && y >= oGame.boundaries[roomID][1]-leeway && y <= oGame.boundaries[roomID][3]+leeway;
}