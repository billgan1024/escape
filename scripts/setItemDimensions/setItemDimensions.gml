function setItemDimensions() {
    //automatically sets the width and height of a menu item 
    //additionally, this sets overallAlpha and overallScale
    //make sure this runs after spr, text, maxWidth, vOffset, and customScale are set
    //called from a menu item
    //basically, this is the 'post-create' event: this runs after all of the variables are updated to their desired
    //values in the create event so that the button is immediately initialized to the correct value
    vOffset *= customScale;
    if(!is_undefined(spr)) { 
		w = (string_width(spr)+h_offset)*customScale;
		h = (string_height(spr)+v_offset)*customScale;
    } else {
		w = (min(string_width(text), maxWidth) + h_offset)*customScale;
		h = (string_height(text)+v_offset)*customScale;
    }
    //updates oPersistent's itemIDs array
    //all variables here are dynamic because the function is called every time the item is loaded
    if(r == span) {
		for(var i = 0; i < oPersistent.maxRow[oPersistent.gameState]; i++) oPersistent.itemIDs[#i, c] = id; 
    } else if(c == span) {
		for(var i = 0; i < oPersistent.maxCol[oPersistent.gameState]; i++) oPersistent.itemIDs[#r, i] = id; 
    } else oPersistent.itemIDs[#r, c] = id;
    
    inStateTransitionAlpha = r >= oPersistent.tr1 && r <= oPersistent.tr2 && c >= oPersistent.tc1 
    && c <= oPersistent.tc2 ? oPersistent.sAlpha : 1;
	flexScale = spr == undefined ? min(maxWidth/string_width(text), 1) : 1;

    overallAlpha = oPersistent.alpha*alphaScale*inStateTransitionAlpha;
	overallScale = scale*flexScale*customScale;
}