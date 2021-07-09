function assignMenuBackgroundItems() {
    //for the 'custom level' state, draw a rectangle which will contain the custom levels 
    //for the level editor state, draw a dark rectangle on the lower half of the screen
    backgroundItems = array_create(gs.length, undefined);
    backgroundItems[gs.select] = [drawSelectBackground, []];
}