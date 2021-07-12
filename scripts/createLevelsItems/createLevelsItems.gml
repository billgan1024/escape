function createLevelsItems() {
	//customLevelPage is a global variable (we want it to persist between transitions)
    loadPage(customLevelPage);
    var labels = ["New Level", "Back"];
    var actions = [undefined, escActions[gameState]];
    #region bottom
    for(var i = 0; i < 2; i++) {
    	with(instance_create_layer(vw/2, 400+120*(i+6), "Persistent", oButton)) {
	    	r = i+4; c = span;
	    	for(var j = 0; j < other.maxCol[other.gameState]; j++) other.itemIDs[#r, j] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			setItemDimensions();
		}
    }
    #endregion
    #region page #
    //create the top tab; it is out of range of the maxRow/maxCol so you can't scroll to it
	with(instance_create_layer(vw/2, 320, "Persistent", oButton)) {
		r = 0; c = 4; other.itemIDs[#r, c] = id; customScale = 0.8;
		text = "Page " + string(other.customLevelPage) + " of " + string(other.maxPage);
		setItemDimensions();
	}
	#endregion
	#region page arrows
	var d = [customLevelPage == 1, customLevelPage == maxPage];
	for(var i = 0; i < 2; i++) {
		with(instance_create_layer(vw/2-160+320*i, 320, "Persistent", oButton)) {
			r = 0; c = i+5; other.itemIDs[#r, c] = id; customScale = 0.8;
			spr = sArrowIcon; disabled = d[i]; if(disabled) { alphaScale = 1/8; alphaScaleTo = 1/8; }
			imageIndex = i; vOffset = 0;
			setItemDimensions();
		}
	}
	#endregion
}

function loadPage(page) {
    //load any particular page by simply assigning text to the existing box(can be used in an in-state transition)
    
    //first, perform a rectangular deletion 
    with(oMenuItem) {
    	if(0 <= r && r < 4 && 0 <= c && c < 4) instance_destroy();
    }
    
    var hs = 540, vs = 150;
    for(var i = 0; i < 4; i++) {
        for(var j = 0; j < 4; j++) {
            var idx = 16*(page-1)+4*i+j;
            with(instance_create_layer(vw/2-hs*1.5+hs*j, 420+vs*i, "Persistent", oButton)) {
                r = i; c = j; other.itemIDs[#r, c] = id;
                up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
				if(idx < ds_list_size(other.levelNames)) text = other.levelNames[|idx];
				else { text = "..."; disabled = true; alphaScale = 1/3; alphaScaleTo = 1/3; }
				setItemDimensions();
            }
        } 
    }
}