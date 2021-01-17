
if(alarms[1] != infinity)
{
	var xx = x-30, yy = y-30;
	draw_healthbar(xx, yy-20, xx+60, yy-10, (1-alarms[1]/fireDelay)*100,
	c_black, colour, colour, 0, true, true);
}
draw_self();