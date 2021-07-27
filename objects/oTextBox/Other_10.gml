if(selected) {
    //make text equal to keyboard_string, but not before checking whether or not you are trying to add new characters to 
    //keyboard_string
    if(text != keyboard_string) {
        textCursor = true; a[1] = 120;
    }
    //finally, clamp the length of keyboard_string and set text
    if(string_length(keyboard_string) > limit) keyboard_string = string_copy(keyboard_string, 1, limit);
    text = keyboard_string;
}