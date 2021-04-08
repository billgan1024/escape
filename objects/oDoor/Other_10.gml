switch(state) {
	case 0:
	if(count == 0 && instance_exists(oPlayer)) {
		var xx = x+30*image_xscale, yy = y+30*image_yscale;
		if(!collision_line(xx, yy, oPlayer.x, oPlayer.y, oGround, false, true) && 
			point_distance(xx, yy, oPlayer.x, oPlayer.y) <= 480) { state = 1; snd(aDoor); }
	}
	break;
	case 1:
	if(dir == "vertical") {
		image_yscale = smoothApproach(image_yscale, 0, 0.03, 0.005);
		if(image_yscale == 0) instance_destroy();
	} else {
		image_xscale = smoothApproach(image_xscale, 0, 0.03, 0.005);
		if(image_xscale == 0) instance_destroy();
	}
	break;
}