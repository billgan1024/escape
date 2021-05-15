a = array_create(16, infinity);
//note: for ease of use, spd will be converted to a proportion of the path length
//and it will also be divided by 4.
spd = 0; rev = true;

startPos = 0;

//option: set revolving point and radial velocity
originX = 0;
originY = 0;
radius = 0;
angularSpd = 0;
angle = 0; startAngle = 0;