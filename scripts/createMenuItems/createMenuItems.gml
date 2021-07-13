function createMenuItems() {
    var labels = ["Play", "Level Editor", "Options", "Quit"];
	//note: gamemaker won't convert functions into integer references, so u need to define all functions yourself
	//e.g. you can't put function() { game_end(); } into actions[]
	var actions = [[transitionTo, [gs.select]], [transitionTo, [gs.levels, 1, 0]], [transitionTo, [gs.options]], [quit, []]];
	#region main
	for(var i = 0; i < 4; i++) {
		with(instance_create_layer(vw/2, 500+120*i, "Persistent", oButton)) {
			r = i; other.itemIDs[#r, c] = id; 
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			setItemDimensions();
		}
	}
	#endregion
}

function quit() { game_end(); }