a = array_create(16, infinity);
spd = 0;
t = 0;
//how many blocks this platform will sway in either direction
radius = 0;
//flip direction?
flip = false;
//duration of one cycle
period = 0;

//wave axis (horizontal or vertical)?
waveDir = "horizontal";

//can make this follow a path
pathIdx = -1;
spd = 0; loop = false;

pos = 0; startPos = 0;

radius = 0;
angularSpd = 0;
angle = 0; startAngle = 0;

offsetX = 0; offsetY = 0; 