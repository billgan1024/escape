if(place_meeting(x, y, oSword)) 
{
	if(oSword.image_alpha == 1)
	{
		with(oPlayer)
		{
			canBlink = true; alarms[4] = infinity;	
		}
		instance_destroy();
	}
}