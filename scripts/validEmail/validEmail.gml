function invalidEmail(str) {
    //gms2 strings are 1-indexed
    return string_pos("@", str) < 2 || string_length(str) < 3 || string_pos("@", str) == string_length(str);
}