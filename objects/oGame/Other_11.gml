/// @description go to the target room
var reset = resetAttempts;
with(oPersistent) {
	transitTo(gs.game, asset_get_index("level" + string(oGame.targetLvl)));
	resetAttempts = reset;
}
a[1] = infinity;
