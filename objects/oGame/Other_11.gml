/// @description go to the target room
with(oPersistent) {
	transitionTo(gs.game, 0, 0, asset_get_index("level" + string(other.targetLvl)));
	resetAttempts = other.resetAttempts;
}
a[1] = infinity;