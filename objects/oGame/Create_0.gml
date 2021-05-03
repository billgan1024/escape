a = array_create(16, infinity);
shake = 0;

targetX = 0; 
targetY = 0;
lvl = real(string_digits(room_get_name(room)));
show_debug_message(lvl);
targetLvl = 0;

yLevel = -1; leftBoundary = 0; rightBoundary = 0;
resetAttempts = false;

borderRadius = 0;

//update camera data:
//get x and y coords of all boundaries in the room
//sort array by y coord first, then x coord
//then update the oPersistent.cameraData array (note that u can edit a lot of 'undefined' areas in a GMS2 array lmao)
if(oPersistent.cameraData[lvl] == -1)
{
	var l = lvl;
	with(oBoundary)
	{
		//append the x coord to the end of data[level][ycoord]
		//note that we can append things by assuming that the position already exists
		var yy = y/vh;
		oPersistent.cameraData[l][yy][array_length(oPersistent.cameraData[l][yy])] = x;
	}
	//finally, sort all of the boundaries by x-coord and adjust the right boundary x-values
	for(var i = 0; i < array_length(oPersistent.cameraData[lvl]); i++) {
		oPersistent.cameraData[lvl][i] = arraySort(oPersistent.cameraData[lvl][i], true);
		for(var j = 1; j < array_length(oPersistent.cameraData[lvl][i]); j += 2) oPersistent.cameraData[lvl][i][j] += 60; 
	}
}
show_debug_message(oPersistent.cameraData);