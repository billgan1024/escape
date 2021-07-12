function setItemDimensions() {
    //automatically sets the width and height of a menu item
    //make sure this runs after spr, text, maxWidth, and customScale are set
    if(!is_undefined(spr)) { 
		w = (string_width(spr)+h_offset)*customScale;
		h = (string_height(spr)+v_offset)*customScale;
    } else {
		w = (min(string_width(text), maxWidth) + h_offset)*customScale;
		h = (string_height(text)+v_offset)*customScale;
    }
}