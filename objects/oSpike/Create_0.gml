a = array_create(16, infinity);
//modular implementation of spike movement functionality:
//the spike can be attached to a moving/stationary point which follows a path. from that point,
//the spike can be coded to revolve around that moving point to allow for more complex movement
//can also toggle absoluteness
//update: now supports automatically creating horizontal and vertical paths
pathIdx = -1;
spd = 0; loop = false;
rotateSpd = 0;

pos = 0; startPos = 0;

radius = 0;
angularSpd = 0;
angle = 0; startAngle = 0;
offsetX = 0; offsetY = 0; 

//update boundaries for hpath using the boundary boxes (for vertical boundaries, it's always
//floor(y/vh)*vh + 30, floor(y/vh)*vh + vh - 30
lb = 0; rb = 0; top = floor(y/vh)*vh; var t = top;
var xList = ds_list_create();
with(oBoundary) {
	if(y == t) ds_list_add(xList, x);
}
ds_list_sort(xList, true);
for(var i = 0; i < ds_list_size(xList); i++) {
	if(i % 2 == 1) {
		xList[|i] += 60;
		if(x >= xList[|i-1] && x <= xList[|i]) {
			lb = xList[|i-1]; rb = xList[|i]; break;
		}
	}
}
//whether or not pathIdx points to a path created in-game (it needs to be destroyed on cleanup)
customPath = false;