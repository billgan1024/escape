function createPausedItems() {
    var labels = ["Back to Game", "Retry Level", "Options", "Main Menu"];
    var actions = [escActions[gs.paused][0], transitionTo, transitionTo, transitionTo];
    //note: even though the game is paused, you can still access oGame's properties
    var args = [escActions[gs.paused][1], [gs.game, 0, 0, room], [gs.optionsGame, 0, 0], [gs.menu, 0, 0, menu, aMenu]];
	for(var i = 0; i < 4; i++) {
		with(instance_create_layer(vw/2, 500+120*i, "Persistent", oButton)) {
			r = i;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = [actions[i], args[i]];
			text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
		}
	}
}