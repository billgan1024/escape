/// @desc ds_map load using arcfour from buffer
/// @arg buffer the buffer to load from
/// @arg key the secret to use to encrypt
function ds_map_arcfour_load_buffer(argument0, argument1) {

	var buff = argument0;
	var key = argument1;

	var str = arcfour_decrypt(key, buff);
	return json_decode(str);


}
