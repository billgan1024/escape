if(ds_map_find_value(async_load, "id") == post) {
	if(ds_map_find_value(async_load, "status") == 0) {
		show_debug_message(ds_map_find_value(async_load, "result"));
	}
}