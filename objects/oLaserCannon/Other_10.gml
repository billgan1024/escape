t += 1/240; 
laserWidth = wave(0.9, 1.1, 0.15, t); 
laserBurstSize = random_range(0.5, 0.8);
image_angle = (image_angle + 0.4) % 360;
c = lightCollision(x, y, x+lengthdir_x(2560, image_angle), y+lengthdir_y(2560, image_angle), oGround, false, false);
var dx = c[1]-x, dy = c[2]-y; len = sqrt(dx*dx + dy*dy);