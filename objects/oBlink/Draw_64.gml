
if(instance_exists(oPlayer))
{
	if(oPlayer.alarms[4] != infinity)
	{
		draw_set_alpha(0.5);
		draw_sprite(oBlink, 0, vw-10, vh-10);
		draw_set_alpha(1); draw_set_colour(c_white);
		draw_set_font(fMain); draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(vw-10-44, vh-10-44, string(oPlayer.alarms[4]/240));
	}
	else
	{
		draw_sprite(oBlink, 0, vw-10, vh-10);
	}
}
else draw_sprite(oBlink, 0, vw-10, vh-10);