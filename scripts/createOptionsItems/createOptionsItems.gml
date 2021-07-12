//accept a state that will be used to decide what state you will transition to once you go back 
function createOptionsItems(escState) {
    var labels = [
    	"Sound FX: " + string(data[?"sfx"]) + "%", 
    	"Music: " + string(data[?"mus"]) + "%", 
    	"Fullscreen: " + (data[?"fs"] ? "On" : "Off"), 
    	"Timer: " + (data[?"timer"] ? "On" : "Off"), 
    ]
    //set actions + args 2 times for different 'groups' of buttons
	var actions = [changeSoundVol, changeMusicVol, [toggleFs, []], [toggleTimer, []]];
    #region audio
    var d = [[data[?"sfx"] == 0, data[?"sfx"] == 100], [data[?"mus"] == 0, data[?"mus"] == 100]];
    for(var i = 0; i < 2; i++) {
    	with(instance_create_layer(vw/2, 400+120*i, "Persistent", oButton)) {
    		r = i; c = 0; other.itemIDs[#r, c] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			left = [actions[i], [-10]];
			right = [actions[i], [10]];
			text = labels[i];
			setItemDimensions();
    	}
		//for the graphics icons, assign (r, c) that is out of bounds so that they won't be selected
		//so that you can play the animation
		for(var j = 0; j < 2; j++) {
			with(instance_create_layer(vw/2-250+500*j, 400+120*i, "Persistent", oButton)) {
				//define buttons which are outside of the maxRow/maxCol so that they are unreachable by keyboard
				r = i; c = j+1; other.itemIDs[#r, c] = id;
				spr = sArrowIcon;
				imageIndex = j;
				enter = [actions[i], [-10+20*j]];
				disabled = d[i][j]; if(disabled) { alphaScale = 1/8; alphaScaleTo = 1/8; }
				willMoveCursor = false;
				scale = 0.8; baseScale = 0.8;
				vOffset = 0;
				setItemDimensions();
    		}
		}	
	}
	#endregion
	#region other options 
	for(var i = 2; i < 4; i++) {
    	with(instance_create_layer(vw/2, 400+120*i, "Persistent", oButton)) {
    		r = i; c = 0; other.itemIDs[#r, c] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			setItemDimensions();
    	}
	}
	#endregion
	#region back
	with(instance_create_layer(vw/2, 400+120*7, "Persistent", oButton)) {
		r = 4; c = span; other.itemIDs[#r, 0] = id;
		up = [changeCursor, [-1, 0]];
		down = [changeCursor, [1, 0]];
		enter = other.escActions[escState];
		text = "Back";
		setItemDimensions();
	}
	#endregion
}

function changeSoundVol(dv) {
	//changes data[?"mus"], then update the gain +  
	data[?"sfx"] = clamp(data[?"sfx"]+dv, 0, 100); save();
	updateSoundVol();
	with(itemIDs[#0, 0]) {
		text = "Sound FX: " + string(other.data[?"sfx"]) + "%"; setItemDimensions(); 
	}
	var d = [data[?"sfx"] == 0, data[?"sfx"] == 100];
	for(var i = 0; i < 2; i++) {
		with(itemIDs[#0, i+1]) { 
			disabled = d[i]; alphaScaleTo = disabled ? 1/8 : 1;
		}
	}
}

//to toggle a switch, this function can also set properties of the current selected object
function changeMusicVol(dv) {
	//changes data[?"mus"], then update the gain + text 
	data[?"mus"] = clamp(data[?"mus"]+dv, 0, 100); save();
	updateMusicVol();
	with(itemIDs[#1, 0]) {
		text = "Music: " + string(other.data[?"mus"]) + "%"; setItemDimensions();
	}
	var d = [data[?"mus"] == 0, data[?"mus"] == 100];
	for(var i = 0; i < 2; i++) {
		with(itemIDs[#1, i+1]) {
			disabled = d[i]; alphaScaleTo = disabled ? 1/8 : 1;
		}
	}
}

function toggleFs() {
	data[?"fs"]	 = !data[?"fs"]; save(); 
	window_set_fullscreen(data[?"fs"]); window_set_size(h/3*4, h/4*3);
	a[1] = 15;
	with(itemIDs[#2, 0]) {
		text = "Fullscreen: " + (other.data[?"fs"] ? "On" : "Off"); setItemDimensions();
	}
	canInteract = false; a[4] = inputDelay*6;
}

function toggleTimer() {
	data[?"timer"] = !data[?"timer"]; save(); 
	with(itemIDs[#3, 0]) {
		text = "Timer: " + (other.data[?"timer"] ? "On" : "Off"); setItemDimensions();
	}
}

