walkSpd = 3.6; 
runSpd = 5.4;
jumpSpd = 6.4;
walkAcc = 3;
grav = 0.08; 
maxGrav = 10; 
airAcc = 0.4;
bufferTime = 15;
jumpPixels = 10;
cameraOffset = 0;
boosted = false;

//input variables
dir = 1;
jump = false;
jumpHeld = false;
dash = false;
down = false;
grip = false;

hsp = 0;
vsp = 0;
khsp = 0;
fric = 0.05;
wallKickSpd = 7;

//state = "ground", "buffer", "jump", "fall", "blink"
state = "ground";

//disable movement for a bit
canMove = false;
a[1] = inputDelay;

a = array_create(16, infinity);

input = array_create(in.length);
input2 = array_create(in.length);

//update the view instantly
camera_set_view_pos(view_camera[0], clamp(oPlayer.x - vw/2 + oPlayer.cameraOffset, 0, room_width-vw), clamp(floor(oPlayer.y/vh)*vh, 0, room_height/vh-1));