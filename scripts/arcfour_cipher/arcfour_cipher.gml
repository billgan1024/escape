/// @desc Use arcfour on a buffer, return a buffer, it's symmetric
/// @arg key Key
/// @arg buffer Input data
function arcfour_cipher(argument0, argument1) {

	var key = argument0;
	var buff = argument1;
	var buff_size = buffer_get_size(buff);

	var state = arcfour_create_state(key);
	var state_size = array_length_1d(state);

	var temp_buff = buffer_create(buff_size, buffer_fixed, 1);
	buffer_seek(buff, buffer_seek_start, 0);

	var j = 0;
	for (var n=1; n<=buff_size; n++) {
		var i = n % state_size;
	    j = (j + state[i]) % state_size

		var k = state[i];
		state[i] = state[j];
		state[j] = k;
	
		var key = state[(state[i] + state[j]) % state_size];
		var in_byte = buffer_read(buff, buffer_u8);
		buffer_write(temp_buff, buffer_u8, key ^ in_byte);
	}

	return temp_buff;


}
