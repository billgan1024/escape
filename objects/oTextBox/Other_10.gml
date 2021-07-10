if(selected) {
    if(string_length(keyboard_string) > limit) keyboard_string = string_copy(keyboard_string, 1, limit);
    text = keyboard_string;
}
