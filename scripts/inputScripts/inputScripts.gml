function checkInput() {
	for(var i = 0; i < in.length; i++) {
		if(i < in.length-3) input[0][i] = keyboard_check(global.inputCodes[i]);	
		else input[0][i] = mouse_check_button(global.inputCodes[i]);	
	}
	
	//if the player is calling it, set appropriate variables
	if(object_index == oPlayer) {
		if(input[1][in.shift] && oPersistent.data[?"toggle-sprint"]) toggledSprint = !toggledSprint;
		
		dirX = input[0][in.right]-input[0][in.left];
		dirY = input[0][in.down]-input[0][in.up];
		
		jump = input[1][in.up] || input[1][in.space];
		jumpHeld = input[0][in.up] || input[0][in.space];
		down = input[0][in.down];
	}
}

function checkInputPressed() {
	for(var i = 0; i < in.length; i++) {
		if(i < in.length-3) input[1][i] |= keyboard_check_pressed(global.inputCodes[i]);	
		else input[1][i] |= mouse_check_button_pressed(global.inputCodes[i]);		
	}
}

function checkInputReleased() {
	for(var i = 0; i < in.length; i++) {
		if(i < in.length-3) input[2][i] |= keyboard_check_released(global.inputCodes[i]);	
		else input[2][i] |= mouse_check_button_released(global.inputCodes[i]);	
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

function bindInput() {
	keyboard_set_map(ord("W"), vk_up); keyboard_set_map(ord("A"), vk_left); 
	keyboard_set_map(ord("S"), vk_down); keyboard_set_map(ord("D"), vk_right);
	keyboard_set_map(191, ord("Z"));
	//note: if you're in a textbox, remember to call keyboard_unset_map() to regain the ability to type wasd
}