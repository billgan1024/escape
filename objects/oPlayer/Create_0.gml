a = array_create(16, infinity);
runSpd = 3.6;
jumpSpd = 5.3;
runAcc = 0.375;
airAcc = 0.2;
coyoteTimeBuffer = 15;
airRes = 0.1; 
canGlide = false;
yscale = 1;

cameraOffsetX = 0;
cameraOffsetY = 0;
cameraSpdX = 0;
cameraSpdY = 0;

//variable to track when the player loses grip on a wall (coyote time implementation for wall jump)
//basically keep track of the grip direction and store it in a variable whenever it changes
//while the timer after the grip changes has not run out, allow the player to wall jump as if they
//are still on the wall
gripLastFrame = 0;
prevGrip = 0;
preparedWallJump = false;
preparedWallJumpBuffer = 20;
wallJumpedThisFrame = false;
//input variables
dirX = 0;
dirY = 0;
jump = false;
jumpHeld = false;
dash = false;
down = false;
grip = false;
//vertical platform boost
//note that this boost is lost immediately after leaving the platform
vPlatformSpd = 0;

hsp = 0;
vsp = 0;
khsp = 0;
fric = 0.024;
wallKickSpd = 4.4;
currentPlatform = noone;

//preparedJump for when you're pressing jump as you're falling 
preparedJump = false;
preparedJumpBuffer = 15;

//state = "ground", "buffer", "jump", "fall", "blink"
state = "djump"; 

//death variable so that the player never gets destroyed
dead = false;

//freecam
freecam = false;

//disable movement for a bit
canInput = false;
a[1] = inputDelay;

toggledSprint = false;

for(var i = 0; i < 3; i++) input[i] = array_create(in.length);

//update the view instantly
//camera_set_view_pos(view_camera[0], clamp(oPlayer.x - vw/2, 0, room_width-vw), clamp(floor(oPlayer.y/vh)*vh, 0, room_height/vh-1));
//increase attempts
oPersistent.attempts++;