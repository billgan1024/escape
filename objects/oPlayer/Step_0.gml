if(oPersistent.gameState != gs.paused && oPersistent.gameState != gs.optionsGame && canMove && !dead) 
{
	checkInputPressed(); checkInputReleased();
	//if(keyboard_check_pressed(vk_up)) snd(aCoin);
}