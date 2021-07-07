if(!inBoundary()) instance_destroy();
smoke(c_orange, 60*5/spd, -0.01, true, 1, x, y);
//show_debug_message([x, y]);
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
 
missileCollision(oGround);