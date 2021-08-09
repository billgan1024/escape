function createLevelsItems() {
	//customLevelPage is a global variable (we want it to persist between transitions)
	//first, set up the custom level buttons without any text
    var hs = 540, vs = 150;
    
    for(var i = 0; i < 4; i++) {
        for(var j = 0; j < 4; j++) {
            with(instance_create_layer(vw/2-hs*1.5+hs*j, 420+vs*i, "Persistent", oButton)) {
                r = i+1; c = j; 
                up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
				updateItemProperties();
            }
        } 
    }
    
    var labels = ["New Level", "Back"];
    var actions = [undefined, escActions[gameState]];
    #region bottom 
    for(var i = 0; i < 2; i++) {
    	with(instance_create_layer(vw/2, 400+120*(i+6), "Persistent", oButton)) {
	    	r = i+5; c = span;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			updateItemProperties();
		}
    }
    #endregion
    #region page #
    //top tab is a spanning tab (occupies row 0)
	with(instance_create_layer(vw/2, 320, "Persistent", oButton)) {
		r = 0; c = span; 
		up = [changeCursor, [-1, 0]];
		down = [changeCursor, [1, 0]];
		updateItemProperties();
		customScale = 0.8;
	}
	#endregion
	#region page arrows (unreachable because they are outside of the subgrid formed by maxRow + maxCol)
	for(var i = 0; i < 2; i++) {
		with(instance_create_layer(vw/2-160+320*i, 320, "Persistent", oButton)) {
			r = 0; c = i+4;  customScale = 0.8;
			spr = sArrowIcon; 
			imageIndex = i; vOffset = 0; willMoveCursor = false;
			updateItemProperties();
		}
	}
	#endregion
	//fill in the data
	//this function also calls setItemDimensions
	loadCustomTab(customLevelPage, false);
    loadCustomPage(customLevelPage);
}

//updates the items at the top (do this before updating the level names)
//update the functions for the arrows and change the name of the tab
//smooth: whether to adjust alphaScaleTo for page arrows
function loadCustomTab(page, smooth) {
    customLevelPage = page;
	var d = [customLevelPage == 1, customLevelPage == maxPage];
	var actions = [[inStateTransition, [1, 0, 4, 3, [loadCustomTab, [customLevelPage-1, true]], [loadCustomPage, [customLevelPage-1]]]], 
		[inStateTransition, [1, 0, 4, 3, [loadCustomTab, [customLevelPage+1, true]], [loadCustomPage, [customLevelPage+1]]]]];
	
	//update page tab
	with(itemIDs[#0, 0]) {
    	text = "Page " + string(other.customLevelPage) + " of " + string(other.maxPage);
		if(!d[0]) left = actions[0]; else left = undefined;
		if(!d[1]) right = actions[1]; else right = undefined;
		updateItemProperties();
	}
	//set the arrow controls to take in mouse input 
    for(var i = 0; i < 2; i++) {
    	with(itemIDs[#0, i+4]) {
    		enter = actions[i]; 
    		disabled = d[i]; 
    		updateItemProperties(smooth);
    	}	
    }
}

function loadCustomPage(page) {
    //load any particular page by simply assigning text to the existing boxes
    for(var i = 0; i < 4; i++) {
        for(var j = 0; j < 4; j++) {
            var idx = 16*(page-1)+4*i+j;
            with(itemIDs[#i+1, j]) {
				if(idx < ds_list_size(other.levelNames)) { 
					text = other.levelNames[|idx]; disabled = false; 
				} else { text = "..."; disabled = true; }
				//post-create event
				updateItemProperties(false, 1/3);
            }
        } 
    }
}