function checkInput() {
	for(var i = 0; i < in.length; i++) {
		input[0][i] = keyboard_check(global.keyCodes[i]);	
	}
}

function checkInputPressed() {
	for(var i = 0; i < in.length; i++) {
		input[1][i] |= keyboard_check_pressed(global.keyCodes[i]);	
	}
}

function checkInputReleased() {
	for(var i = 0; i < in.length; i++) {
		input[2][i] |= keyboard_check_released(global.keyCodes[i]);	
	}
}

//clears all input arrays (down, pressed, released)
function clearInput() {
	for(var i = 0; i < 3; i++) {
		for(var j = 0; j < in.length; j++) {
			input[i][j] = false;
		}
	}
}

