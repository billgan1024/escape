if(inView(0) && !oPlayer.dead && !collision_line(x, y, oPlayer.x, oPlayer.y, oGround, false, false))
{
	image_angle = angleApproach(image_angle, point_direction(x, y, oPlayer.x, oPlayer.y), 1);
	laserAlpha = smoothApproach(laserAlpha, 0.2, 0.16, 0.005);
	var dx = oPlayer.x-x, dy = oPlayer.y-y;
	len = min(1024, sqrt(dx*dx + dy*dy));
} else {
	laserAlpha = smoothApproach(laserAlpha, 0, 0.16, 0.005);
	image_angle = angleApproach(image_angle, angleStart, 1);
}