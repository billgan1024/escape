function init() {
	data[?"fs"] = true;
	data[?"mus"] = 100;
	data[?"sfx"] = 100;
	data[?"timer"] = false;
	data[?"lvl"] = 32;
	save();
}

function loadCustomLevels() {
	if(!directory_exists("levels")) directory_create("levels");
    for(var s = file_find_first("levels/*.dat", 0); s != ""; s = file_find_next()) {
    	log(s);
    	//load each custom level into an entry in the customLevels map
    	//customLevels[?""] = ds_map_secure_load()	
    }
}

function save() { 
	ds_map_secure_save(data, fileName); 
}