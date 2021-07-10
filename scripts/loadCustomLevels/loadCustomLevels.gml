function loadCustomLevels() {
    //load customLevels + establish the right order
    customLevels = ds_map_create();
    
    for(var s = file_find_first("levels/*.dat", 0); s != ""; s = file_find_next()) {
        //s = levelName.dat
       
        var name = string_replace(s, ".dat", "");
        ds_map_add_map(customLevels, name, ds_map_secure_load("levels/" + s));
    }
    file_find_close();
    //set up additional global variables
    minPage = 0; maxPage = min(ceil(ds_map_size(customLevels)/16), 1);
    customLevelPage = 0;
    
    //load the order from the data file
    levelNames = ds_list_create();
    if(!is_undefined(data[?"levelNames"])) ds_list_read(levelNames, data[?"levelNames"]);
    else { data[?"levelNames"] = ds_list_write(levelNames); save(); }
}