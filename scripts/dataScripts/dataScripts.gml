function initData() {
	data[?"fs"] = true;
	data[?"mus"] = 100;
	data[?"sfx"] = 100;
	data[?"timer"] = false;
	data[?"lvl"] = 32;
	saveData();
}

function saveData() { 
	ds_map_arcfour_save(data, fileName); 
}

function loadSettings() {
	fileName = "data.dat";
	data = ds_map_create();
	if(file_exists(fileName)) {	ds_map_destroy(data); data = ds_map_secure_load(fileName); }
	else initData();
}