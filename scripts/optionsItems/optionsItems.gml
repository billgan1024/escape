function optionsItems() {
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
		menuData[gs.options][i] = {
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
		menuData[gs.options][i] = {
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
	
	menuData[gs.options][array_length(menuData[gs.options])] = {
		obj: oButton,
		x: vw/2,
		y: 400+120*7,
		r: 5,
		c: 0,
		up: [changeCursor, [-1, 0]],
		down: [changeCursor, [1, 0]],
		left: undefined,
		right: undefined,
		enter: escActions[gs.options],
		text: "Back"
	}
}

function changeSoundVol(dv) {
	//changes data[?"mus"], then update the gain +  
	data[?"sfx"] = clamp(data[?"sfx"]+dv, 0, 100); save();
	updateSoundVol(); changeText("Sound FX: " + string(data[?"sfx"]) + "%");
}

//to toggle a switch, this function can also set properties of the current selected object
function changeMusicVol(dv) {
	//changes data[?"mus"], then update the gain + text 
	data[?"mus"] = clamp(data[?"mus"]+dv, 0, 100); save();
	updateMusicVol(); changeText("Music: " + string(data[?"mus"]) + "%");
}

function toggleFs() {
	data[?"fs"]	 = !data[?"fs"]; save(); 
	window_set_fullscreen(data[?"fs"]); window_set_size(h/3*4, h/4*3);
	a[1] = 15;
	changeText("Fullscreen: " + (data[?"fs"] ? "On" : "Off"));
}

function toggleTimer() {
	data[?"timer"] = !data[?"timer"]; save(); changeText("Timer: " + (data[?"timer"] ? "On" : "Off"));
}

function toggleSprint() {
	data[?"toggle-sprint"] = !data[?"toggle-sprint"]; save();
	changeText("Toggle Sprint: " + (data[?"toggle-sprint"] ? "On" : "Off"));
}