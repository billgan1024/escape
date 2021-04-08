switch(state) {
	case 0:
	if(count == 0 && instance_exists(oPlayer)) {
		if(!collision_line(x, y, oPlayer.x, oPlayer.y, oGround, false, true) && 
			abs(x-oPlayer.x) <= 360) { state = 1; snd(aDoor); }
	}
	break;
	case 1:
	image_yscale = smoothApproach(image_yscale, 0, 0.03, 0.005);
	if(image_yscale == 0) instance_destroy();
	break;
}