
c = lightCollision(x, y, x+lengthdir_x(1024, image_angle), y+lengthdir_y(1024, image_angle), oGround, false, false);
var dx = c[1]-x, dy = c[2]-y; lightLength = sqrt(dx*dx+dy*dy);
if(!oPlayer.dead 
&& !collision_line(x, y, oPlayer.x, oPlayer.y, oGround, false, false) && !collision_line(x, y, oPlayer.x, oPlayer.y, oMissileBlocker, false, false))
{
	//can see the player
	image_angle = angleApproach(image_angle, point_direction(x, y, oPlayer.x, oPlayer.y), 2.5);
	laserAlpha = smoothApproach(laserAlpha, 0.2, 0.16, 0.005);
	var dx2 = oPlayer.x-x, dy2 = oPlayer.y-y;
	if(collision_line(x, y, c[1], c[2], oPlayer, false, false)) lightLength = sqrt(dx2*dx2 + dy2*dy2);
} else {
	laserAlpha = smoothApproach(laserAlpha, 0, 0.16, 0.005); //approach amnt is 0.16
	image_angle = angleApproach(image_angle, angleStart, 2);
}