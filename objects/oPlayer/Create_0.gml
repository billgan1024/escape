moveSpd = 4; 
sprintSpd = 6;
jumpSpd = 6.9;
runAcc = 3;
grav = 0.09; 
maxGrav = 10; 
airAcc = 0.4;
bufferTime = 20;
jumpPixels = 10;
cameraX = 0;
cameraOffset = 0;

hsp = 0;
vsp = 0;
khsp = 0;
kvsp = 0;
fric = 0.06;
wallKickSpd = 7;

swordAngle = 0;
angleTo = 0;
swordDir = 0;
isAttacking = false;
canAttack = true;
attackDelay = 60;
atkDir = 0;

jump = 0;
lmb = 0;
rmb = 0;

imgAlpha = 1;
alpha = 1;

canBlink = true;
blinkSpd = 12;
blinkTime = 30;
blinkDelay = 360;

alarms = array_create(16, infinity);
//state = "ground", "buffer", "jump", "fall", "blink"
state = "ground";
prevState = "ground";

//show_debug_message(ev_user0);
//show_debug_message(ev_user15);