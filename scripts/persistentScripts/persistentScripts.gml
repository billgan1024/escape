function update() {
	if(variable_instance_exists(id, "a"))
	{
		for(var i = 1; i <= 15; i++) 
		{
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
		if(object_index != oPersistent) update();
	}
}

function updateGlobal() {
    //updates things that are persistent (persistent + menu stuff)
	part_system_update(global.ps_bg);
	update(); 
}

//operate on this array by reference by using the @ accessor
//take in an update function as well
//note that upd() will still be called from the original calling instance (in this case, oPersistent)
/// @param timeArray
/// @param updateFunction
function step(time, upd) {
    time[@1] += time[0]; 
    if(floor(time[1]) != floor(time[1]-time[0]))
    {
    	var rem = floor(time[1]) - floor(time[1]-time[0]);
    	repeat rem {
    		upd();
    	}
    }
}