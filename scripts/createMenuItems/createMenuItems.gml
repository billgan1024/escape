function createMenuItems() {
    var labels = ["Play", "Level Editor", "Options", "Quit"];
	//note: gamemaker won't convert functions into integer references, so u need to define all functions yourself
	//e.g. you can't put function() { game_end(); } into actions[]
	var actions = [transitionTo, transitionTo, transitionTo, quit];
	var args = [[gs.select, 0, 0], [gs.select, 0, 0], [gs.options, 0, 0], []];
	for(var i = 0; i < 4; i++) {
		with(instance_create_layer(vw/2, 500+120*i, "Persistent", oButton)) {
			r = i;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = [actions[i], args[i]];
			text = labels[i];
			w = string_width(labels[i])+h_offset;
			h = string_height(labels[i])+v_offset;
		}
	}
}

function quit() { game_end(); }