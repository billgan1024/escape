/// @desc ds_map save using arcfour
/// @arg map ds_map
/// @arg filename the filename to save
/// @arg key the secret to use to encrypt
function ds_map_arcfour_save(argument0, argument1, argument2) {

	var map = argument0;
	var filename = argument1;
	var key = argument2;

	if (not ds_exists(map, ds_type_map)) {
		return false;
	}

	var str = json_encode(map);
	var enc_buff = arcfour_encrypt(key, str);
	buffer_save(enc_buff, filename);
	buffer_delete(enc_buff);

	return true;


}
