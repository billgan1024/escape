/// @desc Create arcfour state
/// @arg key Key
function arcfour_create_state(argument0) {

	var key = argument0;

	var state_size = 256;
	var key_size = string_byte_length(key)

	var state;
	for (var i=255; i>=0; i--) {
		state[i] = i;
	}

	var j = 0;
	var k;
	for (var i=0; i<state_size; i++) {
		j = (j + state[i] + string_byte_at(key, (i % key_size)+1)) % state_size;
		k = state[i];
		state[i] = state[j];
		state[j] = k;
	}

	return state;


}
