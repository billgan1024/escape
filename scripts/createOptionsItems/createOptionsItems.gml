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
    for(var i = 0; i < 2; i++) {
    	with(instance_create_layer(vw/2, 400+120*i, "Persistent", oButton)) {
    		r = i; c = 1; other.itemIDs[#r, c] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			left = [actions[i], [-10]];
			right = [actions[i], [10]];
			text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
			willScale = false;
    	}
		//for the graphics icons, assign (r, c) that is out of bounds so that they won't be selected
		//so that you can play the animation
		for(var j = 0; j < 2; j++) {
			with(instance_create_layer(vw/2-250+500*j, 400+120*i, "Persistent", oButton)) {
				r = i; c = 2*j; other.itemIDs[#r, c] = id;
				spr = sArrowIcon;
				w = sprite_get_width(spr)+h_offset;
				h = sprite_get_height(spr)+v_offset;
				imageIndex = j;
				enter = [actions[i], [-10+20*j]];
				willMoveCursor = false;
				scale = 0.8; baseScale = 0.8;
				vOffset = 0;
    		}
		}	
	}
	for(var i = 2; i < 4; i++) {
    	with(instance_create_layer(vw/2, 400+120*i, "Persistent", oButton)) {
    		r = i; c = 1; other.itemIDs[#r, c] = id;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
    	}
	}
	with(instance_create_layer(vw/2, 400+120*7, "Persistent", oButton)) {
		r = 4; c = span; other.itemIDs[#r, 0] = id;
		up = [changeCursor, [-1, 0]];
		down = [changeCursor, [1, 0]];
		enter = oPersistent.escActions[escState];
		text = "Back";
		w = string_width(text)+h_offset;
		h = string_height(text)+v_offset;
	}
}

function changeSoundVol(dv) {
	//changes data[?"mus"], then update the gain +  
	data[?"sfx"] = clamp(data[?"sfx"]+dv, 0, 100); save();
	updateSoundVol(); changeText("Sound FX: " + string(data[?"sfx"]) + "%", 0, 1);
}

//to toggle a switch, this function can also set properties of the current selected object
function changeMusicVol(dv) {
	//changes data[?"mus"], then update the gain + text 
	data[?"mus"] = clamp(data[?"mus"]+dv, 0, 100); save();
	updateMusicVol(); changeText("Music: " + string(data[?"mus"]) + "%", 1, 1);
}

function toggleFs() {
	data[?"fs"]	 = !data[?"fs"]; save(); 
	window_set_fullscreen(data[?"fs"]); window_set_size(h/3*4, h/4*3);
	a[1] = 15;
	changeText("Fullscreen: " + (data[?"fs"] ? "On" : "Off"), 2, 1);
	canInteract = false; a[4] = inputDelay*6;
}

function toggleTimer() {
	data[?"timer"] = !data[?"timer"]; save(); changeText("Timer: " + (data[?"timer"] ? "On" : "Off"), 3, 1);
}

