/// @desc Use arcfour on a buffer, return a string containing decrypted data
/// @arg key Key
/// @arg buffer Input data
function arcfour_decrypt(argument0, argument1) {

	var key = argument0;
	var buff = argument1;

	var temp_buff = arcfour_cipher(key, buff);
	buffer_seek(temp_buff, buffer_seek_start, 0);
	var str = buffer_read(temp_buff, buffer_text);
	buffer_delete(temp_buff);

	return str;


}
