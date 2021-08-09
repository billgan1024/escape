/// @description 
t += 1/240;
handleTransition();
handleNotification();
//update the target selector size + vOffset, then make the current selector size + vOffset lerp towards those values
updateSelector();
// log(mouse_check_button(mb_left));

//smooth transition handler for menus and room switching
//when you want to initiate a menu transition, disable interacting and enable snapping
//menu transition: state = 1, room transition: state = 3
//specify a target gameState and target room and target r and c, when the transition
//fully hides the menu/covers the screen, the transition code activates


//handle pausing and menus only if the menu isn't transitioning
hover = false;
if(canInteract) {
	if(menuData[gameState] != undefined) handleMenu();
	//always handle escape function 
	if(input[1][in.esc] && !is_undefined(escActions[gameState])) { 
		script_execute_ext(escActions[gameState][0], escActions[gameState][1]); snd(aSelect); clearInput(); 
	}
}

if(menuData[gameState] == undefined) window_set_cursor(cr_none);
else window_set_cursor(hover ? cr_drag : cr_default);
clearInput();