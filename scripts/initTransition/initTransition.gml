function initTransition() {
    //transition data (handles menu AND room transitions)
    state = 0; alpha = 1; 
    tAlpha = 0; 
    
    //in-state transitions
    sAlpha = 1; 
    tr1 = -1; tc1 = -1; tr2 = -1; tc2 = -1; transitionFunction = undefined;
    
    destState = -1; destRoom = -1; destSong = -1;
    canInteract = false; 
}