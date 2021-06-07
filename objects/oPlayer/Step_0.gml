if(oPersistent.gameState != gs.paused && oPersistent.gameState != gs.optionsGame && canMove && !dead) 
{
	checkInputPressed(); checkInputReleased();
	if(input2[in.shift] && oPersistent.data[?"toggle-sprint"]) toggleSprint = !toggleSprint;
}