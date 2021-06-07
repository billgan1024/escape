if(inView()) { audio_stop_sound(aExplosion2); snd(aExplosion2); }
if(!oPlayer.dead) {
	if(point_distance(x, y, oPlayer.x, oPlayer.y) <= radius) {
		with(oPlayer) death(aExplosion);
	}
}
firework(c_orange, c_orange, 0.1, 2);