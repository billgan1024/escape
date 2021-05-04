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

function checkInputReleased() {
	for(var i = 0; i < in.length; i++) {
		input3[i] |= keyboard_check_released(global.keyCodes[i]);	
	}
}

function clearInput() {
	for(var i = 0; i < in.length; i++) {
		input[i] = false;
	}
}

function clearPressed() {
	for(var i = 0; i < in.length; i++) {
		input2[i] = false;
	}
}

function clearReleased() {
	for(var i = 0; i < in.length; i++) {
		input3[i] = false;
	}
}
