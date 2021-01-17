var xx = x-30, yy = y-30;
if(alarms[1] != infinity)
{
	draw_healthbar(xx, yy-20, xx+60, yy-10, (1-alarms[1]/fireDelay)*100,
	c_black, colour, colour, 0, true, true);
}
if(barrageResting && alarms[2] != infinity)
{
	draw_healthbar(xx, yy-20, xx+60, yy-10, (1-alarms[2]/barrageDelay)*100,
	c_black, colour, colour, 0, true, true);
}
draw_self();