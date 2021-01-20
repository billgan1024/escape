draw_sprite_ext(sPlayer, 0, x, y, 1, 1, 0, c_white, alpha);
if(alpha == 1 && alarms[4] != infinity)
{
	var xx = x-30, yy = y-30;
	draw_healthbar(xx, yy-20, xx+60, yy-10, (1-alarms[4]/blinkDelay)*100,
	c_black, c_white, c_white, 0, true, true);
}
draw_set_font(fMain); draw_set_colour(c_white);
//draw_text(x, y-50, "angleto: " + string(part_system_position()));