function createPausedItems() {
    var labels = ["Back to Game", "Retry Level", "Options", "Main Menu"];
    var actions = [escActions[gs.paused], [transitionTo, [gs.game, 0, 0, room]], [transitionTo, [gs.optionsGame, 1, 0]],
    [transitionTo, [gs.menu, 0, 0, menu, aMenu]]];
    //note: even though the game is paused, you can still access oGame's properties
	for(var i = 0; i < 4; i++) {
		with(instance_create_layer(vw/2, 500+120*i, "Persistent", oButton)) {
			r = i; other.itemIDs[#r, c] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
		}
	}
}