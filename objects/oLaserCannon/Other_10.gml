t += 1/240; 
laserWidth = wave(0.8, 1, 0.15, t); 
laserBurstSize = random_range(0.5, 1);

if(sway) {
	image_angle = wave(angleStart-radius, angleStart+radius, period, t*(flip ? -1 : 1));
}
else image_angle = (image_angle + angularSpd) % 360;

c = lightCollision(x, y, x+lengthdir_x(2560, image_angle), y+lengthdir_y(2560, image_angle), oGround, false, false);
var dx = c[1]-x, dy = c[2]-y; lightLength = sqrt(dx*dx + dy*dy);

if(state == 1) {
    if(!oPlayer.dead && collision_line(x, y, c[1], c[2], oPlayer, false, false)) {
        with(oPlayer) death(aExplosion);
    }
}