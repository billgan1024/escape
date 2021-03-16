checkInput();
if(window_has_focus()) global.timeFactor = min(delta_time/1000000*240, 8);
else global.timeFactor = 0;

gameTimer += global.timeFactor; 

if (floor(gameTimer) != floor(gameTimer - global.timeFactor))
{
	var _remainder = floor(gameTimer) - floor(gameTimer - global.timeFactor);
	
	repeat _remainder
	{
		part_system_update(global.ps_above);
		part_system_update(global.ps_below);
		//note: because of oPersistent's handling of inputs,
		//you may need to have the user event 0 run after
		//every other instance has finished running
		//in order to let other objects use keyPressed events
		with(all) {
			if(object_index != oPersistent) update();
		}
		update();
	}
}
