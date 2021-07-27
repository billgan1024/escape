/// @desc ds_map save using arcfour, into a buffer
/// @arg map ds_map
/// @arg key the secret to use to encrypt
function ds_map_arcfour_save_buffer(argument0, argument1) {

	var map = argument0;
	var key = argument1;

	if (not ds_exists(map, ds_type_map)) {
		return false;
	}

	var str = json_encode(map);
	return arcfour_encrypt(key, str);


}
