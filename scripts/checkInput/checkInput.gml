function checkInput() {
	//update global.inputs to be used in menus and player
	for(var i = 0; i < array_length(inputKeys); i++) {
		ds_map_replace(global.inputs, inputKeys[i], keyboard_check(inputKeys[i]));
	}
	for(var i = 0; i < array_length(inputKeys2); i++) {
		ds_map_replace(global.inputs2, inputKeys2[i], keyboard_check_pressed(inputKeys2[i]));
	}
}

function clearPressed() {
	for(var i = 0; i < array_length(inputKeys2); i++) {
		ds_map_replace(global.inputs2, inputKeys2[i], 0);
	}
}
