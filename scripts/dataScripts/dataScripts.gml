function init() {
	ds_map_add(data, "fs", true);
	ds_map_add(data, "mus", 100);
	ds_map_add(data, "sfx", 100);
	ds_map_add(data, "timer", false);
	ds_map_add(data, "lvl", 1);
	save();
}

function save() { ds_map_secure_save(data, fileName); }