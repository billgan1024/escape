/// @desc Use arcfour on a string, return a buffer containing encrypted data
/// @arg key Key
/// @arg str Input data
function arcfour_encrypt(argument0, argument1) {

	var key = argument0;
	var str = argument1;

	var str_size = string_byte_length(str);
	var temp_buff = buffer_create(str_size, buffer_fixed, 1);
	buffer_write(temp_buff, buffer_text, str);
	var buff = arcfour_cipher(key, temp_buff);
	buffer_delete(temp_buff);

	return buff;


}
