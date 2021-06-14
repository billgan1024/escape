t += 1/240; 
y = wave(ystart-8, ystart+8, 1.5, t);

switch(state) {
	case 0: 
	if(place_meeting(x, y, oPlayer)) {
		snd(aGem);
		light(c_orange, 1.2);
		firework(c_orange, c_orange);
		shrink(sGemOrange);
		oPlayer.vsp = -boost; oPlayer.boosted = true;
		oPlayer.a[4] = 90; oPlayer.state = "boosted";
		state = 1;
	}
	break;
}