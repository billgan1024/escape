t += 1/240; //image_angle += 0.75;
y = wave(ystart-8, ystart+8, 1.5, 0, t);
if(place_meeting(x, y, oPlayer)) {
	audio_play_sound(aGem, 0, false);
	light(c_green, 1);
	firework(c_white, c_green);
	shrink(sGem);
	oGame.targetLvl = oGame.lvl+1; oGame.a[1] = 120;
	instance_destroy();
}