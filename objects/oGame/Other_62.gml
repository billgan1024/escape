/// @description retrieve all death locations and plot them 
if(async_load[?"id"] == get) {
	if(async_load[?"status"] == 0) {
		surface_set_target(surf);
		var deaths = json_decode(async_load[?"result"])[?"default"];
		for(var i = 0; i < ds_list_size(deaths); i++) {
			var d = deaths[|i]; 
			if(d[?"level"] == lvl) draw_circle_colour(d[?"xpos"], d[?"ypos"], 15, c_aqua, c_blue, false);
		}
		surface_save(surf, room_get_name(room) +".png");
		surface_reset_target();
	}
}