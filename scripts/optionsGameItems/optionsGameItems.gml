function optionsGameItems() {
    var labels = [
    	"Sound FX: " + string(data[?"sfx"]) + "%", 
    	"Music: " + string(data[?"mus"]) + "%", 
    	"Fullscreen: " + (data[?"fs"] ? "On" : "Off"), 
    	"Timer: " + (data[?"timer"] ? "On" : "Off"), 
    	"Toggle Sprint: " + (data[?"toggle-sprint"] ? "On" : "Off") 
    ]
    //set actions + args 2 times for different 'groups' of buttons
	var actions = [changeSoundVol, changeMusicVol, toggleFs, toggleTimer, toggleSprint];
    for(var i = 0; i < 2; i++) {
		menuData[gs.optionsGame][i] = {
		    obj: oButton,
			x: vw/2,
			y: 400+120*i,
			r: i,
			c: 0,
			up: [changeCursor, [-1, 0]],
			down: [changeCursor, [1, 0]],
			left: [actions[i], [-10]],
			right: [actions[i], [10]],
			enter: undefined,
			text: labels[i]
		}
	}
	for(var i = 2; i < 5; i++) {
		menuData[gs.optionsGame][i] = {
		    obj: oButton,
			x: vw/2,
			y: 400+120*i,
			r: i,
			c: 0,
			up: [changeCursor, [-1, 0]],
			down: [changeCursor, [1, 0]],
			left: undefined,
			right: undefined,
			enter: [actions[i], []],
			text: labels[i]
		}
	}
	
	menuData[gs.optionsGame][array_length(menuData[gs.optionsGame])] = {
		obj: oButton,
		x: vw/2,
		y: 400+120*7,
		r: 5,
		c: 0,
		up: [changeCursor, [-1, 0]],
		down: [changeCursor, [1, 0]],
		left: undefined,
		right: undefined,
		enter: escActions[gs.optionsGame],
		text: "Back"
	}
}

