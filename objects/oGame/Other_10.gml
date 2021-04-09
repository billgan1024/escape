shake = approach(shake, 0, 0.08);
if(instance_exists(oPlayer))
{
	targetX = smoothApproach(vx, clamp(oPlayer.x - vw/2 + oPlayer.cameraOffset, 
		leftBoundary, rightBoundary), 0.01);
	targetY =  clamp(floor(oPlayer.y/vh)*vh, 0, room_height-vh);
	
	//check if player's y-level changed
	var newLevel = targetY/vh;
	if(newLevel != yLevel) {
		if(oPersistent.cameraData[lvl] == -1) { leftBoundary = 0; rightBoundary = room_width-vw; }
		else {
			//loop through all intervals at this y-level; if the player's x coord
			//falls in one of them, set the new left and right boundaries to be this interval
			for(var i = 0; i < array_length(oPersistent.cameraData[lvl][newLevel]); i++) {
				var newLeft = oPersistent.cameraData[lvl][newLevel][i][0], newRight = oPersistent.cameraData[lvl][newLevel][i][1];
				if(oPlayer.x >= newLeft && oPlayer.y <= newRight) {
					leftBoundary = newLeft; rightBoundary = newRight-vw; break;
				}
			}
			//deactivate everything except for key objects,
			//then activate te region
			instance_deactivate_all(true);
			instance_activate_object(oPersistent);
			instance_activate_object(oBg);
			instance_activate_object(oDrawCoin);
			//note: region checks intersections of bounding boxes,
			//since falling/moving platforms have sNone if the player's not above them,
			//they wont activate so you need to activate them manually
			instance_activate_object(oFallingPlatform);
			instance_activate_object(oMovingPlatform);
			//activate region
			instance_activate_region(leftBoundary, targetY, rightBoundary-leftBoundary+vw, vh, true);
		}
		//reset enemies after the new ones are active
		resetArea(); 
	}
}

camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake), targetY);
yLevel = targetY/vh;