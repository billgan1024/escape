moveSpd = 4; 
jumpSpd = 7.5;
runAcc = 3;
grav = 0.1; 
maxGrav = 10; 
airAcc = 0.2;
bufferTime = 20;
jumpPixels = 10;

hsp = 0;
vsp = 0;
khsp = 0;
kvsp = 0;
fric = 0.06;
wallKickSpd = 7;

jump = 0;
lmb = 0;
rmb = 0;

blinkSpd = 12;
blinkTime = 40;

alarms = array_create(16, infinity);
//state = "ground", "buffer", "jump", "fall", "blink"
state = "ground";
prevState = "ground";

//show_debug_message(ev_user0);
//show_debug_message(ev_user15);