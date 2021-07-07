function createLevelsItems() {
    //function for creating the list of levels in the menu room
    
    //load all levels into the customLevels struct
    customLevels = ds_map_create();
    for(var s = file_find_first("levels/*.dat", 0); s != ""; s = file_find_next()) {
        //s = levelName.dat
        
        //this code will not convert the map into a list when you use json_encode
        //customLevels[?string_replace(s, ".dat", "")] = ds_map_secure_load("levels/" + s);
        
        //this code will convert the nested map to nested json structures
        ds_map_add_map(customLevels, string_replace(s, ".dat", ""), ds_map_secure_load("levels/" + s));
    }
    file_find_close();
    
    //with ds_map_add_map, arrays are loaded as lists, and structs are loaded as json objects 
    //i.e. customLevels[?"test"][?"level"][0][$"x"] will not work here
    log(customLevels[?"test"][?"level"][|0][?"x"]);
    log(customLevels[?"test"][?"level"][|0][?"y"]);
    log(json_encode(customLevels));
}