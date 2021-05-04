c = lightCollision(x, y, x+lengthdir_x(1024, image_angle), y+lengthdir_y(1024, image_angle), oGround, false, false);
if(!oPlayer.dead && !collision_line(x, y, oPlayer.x, oPlayer.y, oGround, false, false) && !collision_line(x, y, oPlayer.x, oPlayer.y, oInvis, false, false))
{
	image_angle = angleApproach(image_angle, point_direction(x, y, oPlayer.x, oPlayer.y), 2.5);
	laserAlpha = smoothApproach(laserAlpha, 0.2, 0.16, 0.005);
	var dx = oPlayer.x-x, dy = oPlayer.y-y;
	var dx2 = c[1]-x, dy2 = c[2]-y;
	len = min(sqrt(dx*dx + dy*dy), sqrt(dx2*dx2 + dy2*dy2));
} else {
	var dx = c[1]-x, dy = c[2]-y; len = sqrt(dx*dx + dy*dy);
	laserAlpha = smoothApproach(laserAlpha, 0, 0.16, 0.005);
	image_angle = angleApproach(image_angle, angleStart, 2);
}