a = array_create(16, infinity);
shake = 0;

//cameraX, cameraY = camera position which will approach the player's position + player's offset
cameraX = 0; cameraY = 0;
//keep track of an internal camera state
//this is for vertical camera movement
//ground: only approach player's y position if the player is on the ground
//also check if player moved to the top or bottom of the screen; if so, then switch to follow
//follow: always approach the player's y position smoothly, with a certain max speed 

//avoid race condition with the player's first update event
vState = "follow";
//vlevel: y-level of the ground the player is standing on
//this is so that the game 'remembers' what you were standing on previously so it can continue
//approaching that level
vLevel = 0;

//vertical section length in which the camera switches state
vSection = 400;
//max # of pixels to move per second vertically when you're smoothly approaching the player's
//y-value
vMaxApproachRate = 4;

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
	array_push(other.boundaries[r], x);
	array_push(other.boundaries[r], y);
	log(x, y);
}

for(var i = 0; i < len(boundaries); i++) {
	if(boundaries[i][0] > boundaries[i][2]) swap(boundaries[i], 0, 2);
	if(boundaries[i][1] > boundaries[i][3]) swap(boundaries[i], 1, 3);
	boundaries[i][2] += 60; boundaries[i][3] += 60;
}
log(boundaries);