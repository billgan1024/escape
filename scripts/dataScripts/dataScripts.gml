function init() {
	data[?"fs"] = true;
	data[?"mus"] = 100;
	data[?"sfx"] = 100;
	data[?"timer"] = false;
	data[?"lvl"] = 10;
	save();
}

function save() { 
	ds_map_secure_save(data, fileName); 
}