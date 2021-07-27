/// @desc ds_map load using arcfour
/// @arg filename the filename to save
/// @arg key the secret to use to encrypt
function ds_map_arcfour_load(argument0, argument1) {

	var filename = argument0;
	var key = argument1;

	var enc_buff = buffer_load(filename);
	if (enc_buff < 0) {
		return -1;
	}

	var str = arcfour_decrypt(key, enc_buff);
	buffer_delete(enc_buff);

	return json_decode(str);


}
