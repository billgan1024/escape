//var rm_name = room_get_name(room);
//surface_save(application_surface, "screenshot_" + string(rm_name) +".png");
var surf = surface_create(1024, 1024);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_set_colour(c_black);
draw_rectangle(0, 0, 50, 50, false);
surface_reset_target();
surface_save(surf, "bruh.png");