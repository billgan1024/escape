function checkEnemy() {
	if(y-30 >= room_height) death(aSplat);
	if(place_meeting(x, y, oEnemyParent)) {
		death(aExplosion);
		with(instance_place(x, y, oEnemyParent)) {
			if(object_index == oMissile) {
				instance_destroy();
				snd(aExplosion2);
				firework(c_orange, c_orange, 0.1, 2);
			}
		}
	}
}