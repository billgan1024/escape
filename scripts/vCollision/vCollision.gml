function vCollision() {
	//platforms are only going to have a hitbox if the player is on top of them so 
	//you don't need to check whether vsp >= 0
	if(place_meeting(x, y+vsp, oGround) || place_meeting(x, y+vsp, oPlatform))
	{
		while(!place_meeting(x, y+sign(vsp), oGround) && !place_meeting(x, y+sign(vsp), oPlatform)) y += sign(vsp);
		vsp = 0;
		//touched ground
		if(object_index == oPlayer) changeState();
	}
	y += vsp;	
}