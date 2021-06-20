function pausedItems() {
    var labels = ["Back to Game", "Retry Level", "Options", "Main Menu"];
    var actions = [escActions[gs.paused][0], transitionTo, transitionTo, transitionTo];
    //note: even though the game is paused, you can still access oGame's properties
    var args = [escActions[gs.paused][1], [gs.game, 0, 0, -2], [gs.optionsGame, 0, 0], [gs.menu, 0, 0, menu, aMenu]];
	for(var i = 0; i < 4; i++) {
		menuData[gs.paused][i] = {
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