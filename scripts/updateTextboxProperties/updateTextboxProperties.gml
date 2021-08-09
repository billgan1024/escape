function updateTextboxProperties() {
    ds_list_add(oPersistent.textboxIDs, id);
    //update the necessary properties after the custom ones have been set to avoid flickering
    //update drawText
    if(passwordField) {
        //do this calculation only when the lengths differ
        if(string_length(drawText) != string_length(text)) {
            drawText = "";
            for(var i = 0; i < string_length(text); i++) drawText += "*";
        }
    } else drawText = text;
    
    //update scale factors
    flexScale = min((w-60)/(string_width(drawText)*mainTextBoxScale), 1);
    cursorOffset = string_width(drawText)*mainTextBoxScale*flexScale/2+(string_length(drawText) > 0 ? 3 : 0);
}