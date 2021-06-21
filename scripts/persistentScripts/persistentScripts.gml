function checkSelected() {
	with(oButton) {
		if((oPersistent.r == r || r == span) && (oPersistent.c == c || c == span)) {
			oPersistent.cur = id; updateSelectorTo(x, y, w, h); 
		}
	}
}

function updateSelector() {
	for(var i = 0; i < 4; i++) selectorFrom[i] = smoothApproach(selectorFrom[i], selectorTo[i], snap ? 1 : 0.12); 
}

function updateSelectorTo() {
	for(var i = 0; i < 4; i++) oPersistent.selectorTo[i] = argument[i]; 
	oPersistent.selectorTo[2] += 30; 
	oPersistent.selectorTo[3] += 9; 
}

function update() {
	if(variable_instance_exists(id, "a")) {
		for(var i = 1; i <= 15; i++) {
			a[i]--;
			if(a[i] <= 0) {
				event_perform(ev_other, i+10);
			}
		}
	}
	event_perform(ev_other, ev_user0);
}

function updateLocal() {
    //updates things that can be paused (everything in game)
	part_system_update(global.ps_above);
	part_system_update(global.ps_below); 
	with(all) {
		if(object_index != oPersistent && object_index != oMenuItem) update();
	}
}

function updateGlobal() {
    //updates things that are persistent (persistent + menu stuff)
	part_system_update(global.ps_bg);
	with(oMenuItem) update();
	update(); 
}

//operate on this array by reference by using the @ accessor
//take in an update function as well (upd is a function's integer reference)
//note that upd() will still be called from the original calling instance (in this case, oPersistent)
function step() {
    time[1] += time[0]; 
    if(floor(time[1]) != floor(time[1]-time[0]))
    {
    	var rem = floor(time[1]) - floor(time[1]-time[0]);
    	repeat rem {
	    	if(gameState != gs.paused && gameState != gs.optionsGame) updateLocal();
    		updateGlobal();
    	}
    }
}