function checkEnemy() {
	if(y-30 >= room_height) death(aSplat);
	var enemy = instance_place(x, y, oEnemyParent);
	if(enemy != noone) {
		death(aExplosion);
		with(enemy) {
			if(enemy.object_index == oMissile) {
				instance_destroy();
				snd(aExplosion2);
				firework(c_orange, c_orange, 0.1, 2);
			}
		}
	}
}