function createMenuItems() {
    var labels = ["Play", "Level Editor", "Options", "Quit"];
	//note: gamemaker won't convert functions into integer references, so u need to define all functions yourself
	//e.g. you can't put function() { game_end(); } into actions[]
	var actions = [[transitionTo, [gs.select]], [transitionTo, [gs.levels]], [transitionTo, [gs.options, 0, 1]], [quit, []]];
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

function quit() { game_end(); }