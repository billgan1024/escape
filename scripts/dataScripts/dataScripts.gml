function initData() {
	data = ds_map_create();
	data[?"fs"] = true;
	data[?"mus"] = 100;
	data[?"sfx"] = 100;
	data[?"timer"] = false;
	data[?"lvl"] = 32;
	saveData();
}

function saveData() { 
	ds_map_secure_save(data, fileName); 
}

function loadData() {
	fileName = "data.dat";
	//note: ds_map_secure_load automatically ensures that the game doesn't crash when the file doesn't exist
	//in the case of an error, the map index will be -1 if something goes wrong
	data = ds_map_secure_load(fileName); 
	if(data == -1) initData();
}