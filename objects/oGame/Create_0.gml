a = array_create(16, infinity);
shake = 0;

//cameraX, cameraY = camera position which will approach the player's position + player's offset
cameraX = 0; cameraY = 0;
//keep track of an internal camera state
//this is for vertical camera movement
//ground: only approach player's y position if the player is on the ground
//also check if player moved to the top or bottom of the screen; if so, then switch to follow
//follow: always approach the player's y position smoothly, with a certain max speed 

lvl = real(string_digits(room_get_name(room)));
targetLvl = 0;
t = 0;

resetAttempts = false;

borderRadius = 0;

roomID = 0;
//make sure boundary boxes are created before this object
//so that the variable r exists
boundingBox = undefined;
boundaries = array_create(instance_number(oBoundary)/2, []);
with(oBoundary) {
	other.boundaries[r][len(other.boundaries[r])] = x;
	other.boundaries[r][len(other.boundaries[r])] = y;
}

for(var i = 0; i < len(boundaries); i++) {
	if(boundaries[i][0] > boundaries[i][2]) swap(boundaries[i], 0, 2);
	if(boundaries[i][1] > boundaries[i][3]) swap(boundaries[i], 1, 3);
	boundaries[i][2] += 60; boundaries[i][3] += 60;
}

// log(boundaries);