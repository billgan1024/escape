function updateItemProperties(smooth, disabledAlpha) {
    //automatically sets the width and height of a menu item 
    //make sure this runs after every attribute is set
    //this function is called from a menu item
    //basically, this is the 'post-create' event: this runs after all of the variables are updated to their desired
    //values in the create event so that the button is immediately initialized to the correct value
    
    //exploit default parameters
    if(is_undefined(smooth)) smooth = true;
    if(is_undefined(disabledAlpha)) disabledAlpha = 1/8;
    vOffset = bottom_offset*customScale;
    if(!is_undefined(spr)) { 
		w = (string_width(spr)+h_offset)*customScale;
		h = (string_height(spr)+v_offset)*customScale;
    } else {
		w = (min(string_width(text), maxWidth) + h_offset)*customScale;
		h = (string_height(text)+v_offset)*customScale;
    }
    //updates oPersistent's itemIDs array
    //all variables here are dynamic because the function is called every time the item is loaded
    //r == span: takes up all rows
    //c == span: takes up all columns
    if(r == span) {
    	with(oPersistent) {
			for(var i = 0; i < stateData[gameState][$"maxRow"]; i++) itemIDs[#i, other.c] = other.id; 
    	}
    } else if(c == span) {
		with(oPersistent) {
			for(var i = 0; i < stateData[gameState][$"maxCol"]; i++) itemIDs[#other.r, i] = other.id; 
    	}
    } else oPersistent.itemIDs[#r, c] = id;
    
    //immediately update alpha and image scale to prevent flickering when it is drawn for the first time
    //(more often than not, the first draw event occurs before the first other_user0 event)
    alphaScaleTo = disabled ? disabledAlpha : 1; if(!smooth) alphaScale = alphaScaleTo;
    
    inStateTransitionAlpha = r >= oPersistent.tr1 && r <= oPersistent.tr2 && c >= oPersistent.tc1 
    && c <= oPersistent.tc2 ? oPersistent.sAlpha : 1;
	flexScale = spr == undefined ? min(maxWidth/string_width(text), 1) : 1;
    overallAlpha = oPersistent.alpha*alphaScale*inStateTransitionAlpha;
	overallScale = scale*flexScale*customScale;
}