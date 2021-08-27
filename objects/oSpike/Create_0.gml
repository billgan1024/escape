a = array_create(16, infinity);
//modular implementation of spike movement functionality:
//the spike can be attached to a moving/stationary point which follows a path. from that point,
//the spike can be coded to revolve around that moving point to allow for more complex movement
//can also toggle absoluteness
//update: now supports automatically creating horizontal and vertical paths
//and also the default behaviour is a spike with speed 0
pathIdx = -1;
spd = 0; loop = false;
rotateSpd = 1;

pos = 0; startPos = 0;

radius = 0;
angularSpd = 0;
angle = 0; startAngle = 0;
offsetX = 0; offsetY = 0; 

//update boundaries for hpath using the boundary boxes (for vertical boundaries, it's always
//floor(y/vh)*vh + 30, floor(y/vh)*vh + vh - 30
//this is used by hpath() and vpath() in the creation code, which always runs after the create event.
//whether or not pathIdx points to a path created in-game (it needs to be destroyed on cleanup)

//what room this spike exists in (for boundaries)
roomID = getBoundingBoxID();
customPath = false;