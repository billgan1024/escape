function checkInput() {
	for(var i = 0; i < in.length; i++) {
		input[i] = keyboard_check(global.keyCodes[i]);	
	}
}

function checkInputPressed() {
	for(var i = 0; i < in.length; i++) {
		input2[i] |= keyboard_check_pressed(global.keyCodes[i]);	
	}
}

function clearPressed() {
	for(var i = 0; i < in.length; i++) {
		input2[i] = false;
	}
}
