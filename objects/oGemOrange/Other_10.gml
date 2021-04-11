t += 1/240; 
y = wave(ystart-8, ystart+8, 1.5, t);
if(place_meeting(x, y, oPlayer)) {
	snd(aGem);
	light(c_orange, 1.2);
	firework(c_orange, c_orange);
	shrink(sGemOrange); oGame.resetAttempts = true;
	oPlayer.vsp = -boost; oPlayer.boosted = true;
	instance_destroy();
}