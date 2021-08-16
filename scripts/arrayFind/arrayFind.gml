function arrayFind(arr, elem) {
    for(var i = 0; i < len(arr); i++) {
        if (arr[i] == elem) return i;
    }
    return -1;
}