function selectItems() {
    for(var i = 0; i < 4; i++) {
		for(var j = 0; j < 8; j++) {
			menuData[gs.select][8*i+j] = {
				obj: oButton,
				x: vw/2-120*3.5+120*j,
				y: 400+120*i,
				r: i,
				c: j,
				up: [changeCursor, [-1, 0]],
				down: [changeCursor, [1, 0]],
				left: [changeCursor, [0, -1]],
				right: [changeCursor, [0, 1]],
				enter: [transitionTo, [gs.game, 0, 0, asset_get_index("level" + string(8*i+j+1)), aGame]],
				text: 8*i+j+1
			}
		}
	}
	menuData[gs.select][array_length(menuData[gs.select])] = {
		obj: oButton,
		x: vw/2,
		y: 400+120*7,
		r: 4,
		c: -1,
		up: [changeCursor, [-1, 0]],
		down: [changeCursor, [1, 0]],
		left: undefined,
		right: undefined,
		enter: escActions[gs.select],
		text: "Back"
	}
}