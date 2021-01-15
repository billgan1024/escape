global.timeFactor = min(delta_time/1000000*240, 8);

// INCREMENT GAME TIMER
gameTimer += global.timeFactor; 

// UPDATE PARTICLE SYSTEM ON EACH FRAME (ACCOUNTING FOR TIME DILATION. 
// IF THE TIME DILATION IS > 0, WE WILL SOMETIMES END UP NEEDING TO UPDATE 2X ON THE SAME FRAME
if (floor(gameTimer) != floor(gameTimer - global.timeFactor))
{
	var _remainder = floor(gameTimer) - floor(gameTimer - global.timeFactor);
	
	repeat _remainder
	{
		part_system_update(global.ps_above);
		part_system_update(global.ps_below);
		part_system_update(0);
		part_system_update(1);
		with(all)
		{
			if(ds_list_find_index(oPersistent.noAlarms, object_index) == -1) check_alarms();
			event_perform(ev_other, ev_user0);
		}
	}
}