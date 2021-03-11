alarms = array_create(16, infinity);
alarms[2] = random_range(4, 5);
delay = 120; angle = 0; alarms[1] = 120; 
cannonState = 0; //0 = not doing stuff, 1 = about to fire, 2 = firing
rspd = -0.4;
laserWidth = 12;
sz = 0;
t = 0;
c[1] = 0; c[2] = 0;