switch(state) {
	case 0:
		image_alpha = approach(image_alpha, 1, fadeSpeed); 
		if(image_alpha == 1) {
			global.gameState = destState; room_goto(destRoom); state++;
		}
	break;
	case 1:
		image_alpha = approach(image_alpha, 0, fadeSpeed); 
		if(image_alpha == 0) instance_destroy();
	break;
}
