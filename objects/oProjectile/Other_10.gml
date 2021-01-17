if(place_meeting(x, y, oGround)) 
{
	instance_destroy();
	effect_create_above(ef_firework, x, y, 0, colour);
}