if(window_has_focus()) global.timeFactor = min(delta_time/1000000*240, 8);
else global.timeFactor = 0;

// INCREMENT GAME TIMER
gameTimer += global.timeFactor; 
//window_set_size(display_get_height()/3*4, display_get_height()/4*3);
//part_system_automatic_update(0, false);
//part_system_automatic_update(1, false);

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