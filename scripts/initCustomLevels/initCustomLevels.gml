function initCustomLevels() {
    if(!directory_exists("levels")) directory_create("levels");
    customLevels = ds_map_create();
    
    for(var s = file_find_first("levels/*.dat", 0); s != ""; s = file_find_next()) {
        //s = levelName.dat
       
        var name = string_replace(s, ".dat", "");
        ds_map_add_map(customLevels, name, ds_map_secure_load("levels/" + s));
    }
    file_find_close();
    
    //load the order from the data file
    levelNames = ds_list_create();
    if(!is_undefined(data[?"levelNames"])) ds_list_read(levelNames, data[?"levelNames"]);
    else { data[?"levelNames"] = ds_list_write(levelNames); save(); } 
    for(var i = 0; i < 16*3-5; i++) ds_list_add(levelNames, "test"+string(i));
    
    //track current page (maintain this as a global variable that doesn't get reset between room changes)
    minPage = 1; maxPage = max(ceil(ds_list_size(levelNames)/16), 1);
    customLevelPage = 1;
}