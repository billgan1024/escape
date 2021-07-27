t += 1/240; //image_angle += 0.75;
y = wave(ystart-8, ystart+8, 1.5, t);
if(place_meeting(x, y, oPlayer)) {
	snd(aGem);
	light(c_green, 1.2);
	firework(c_white, c_green);
	shrink(sGem);
	oGame.targetLvl = oGame.lvl+1; oGame.a[1] = 120; oGame.resetAttempts = true;
	if(oPersistent.transmitData) logCompletion(oGame.lvl, oPersistent.attempts, oGame.t);
	instance_destroy();
}