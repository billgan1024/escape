function inBoundary() {
    //allow leeway for bullets to disappear naturally
    var leeway = 120;
    return x >= oGame.boundaries[0]-leeway && x <= oGame.boundaries[2]+leeway 
    && y >= oGame.boundaries[1]-leeway && y <= oGame.boundaries[3]+leeway;
    }