function menuItems() {
    var labels = ["Play", "Level Select", "Options", "Quit"];
	//note: gamemaker won't convert functions into integer references, so u need to define all functions yourself
	//e.g. you can't put function() { game_end(); } into actions[]
	var actions = [transitionTo, transitionTo, transitionTo, quit];
	var args = [[gs.game, 0, 0, level1, aGame], [gs.select, 0, 0, -1], [gs.options, 0, 0, -1], []];
	for(var i = 0; i < 4; i++) {
		//note: array_push is buggy, use dynamic allocation instead 
		//you can also pass in arrays to be assigned to the menu item later. 
		//u pass in a reference to a function (id #) in order to execute it later with oPersistent (with arguments)
		menuData[gs.menu][i] = {
		    obj: oButton,
			x: vw/2,
			y: 500+120*i,
			r: i,
			c: 0,
			up: [changeCursor, [-1, 0]],
			down: [changeCursor, [1, 0]],
			left: undefined,
			right: undefined,
			enter: [actions[i], args[i]],
			text: labels[i]
		}
	}
}

function quit() { game_end(); }