//show_debug_message(vx);
shake = approach(shake, 0, 0.08);
borderRadius = smoothApproach(borderRadius, oPlayer.freecam ? 30 : 0, 0.08);
if(!oPlayer.dead && !oPlayer.freecam) {
	targetX = smoothApproach(vx, clamp(oPlayer.x-vw/2+oPlayer.cameraOffset, 
		leftBoundary, rightBoundary), 0.01);
	targetY =  clamp(floor(oPlayer.y/vh)*vh, 0, room_height-vh);
	
	//check if player exited the current section
	var newLevel = targetY/vh;
	//important note: left and right boundary is for the camera which has a top-left origin
	//this means that when querying the actual area for the player's location,
	//add vw to the right boundary
	if(newLevel != yLevel || oPlayer.x > rightBoundary+vw || oPlayer.x < leftBoundary) {
		if(oPersistent.cameraData[lvl] == -1) { leftBoundary = 0; rightBoundary = room_width-vw; }
		else {
			//loop through all intervals at this y-level; if the player's x coord
			//falls in one of them, set the new left and right boundaries to be this interval
			for(var i = 0; i < array_length(oPersistent.cameraData[lvl][newLevel]); i++) {
				var newLeft = oPersistent.cameraData[lvl][newLevel][i][0], newRight = oPersistent.cameraData[lvl][newLevel][i][1];
				show_debug_message(newLeft);
				show_debug_message(newRight);
				if(oPlayer.x >= newLeft && oPlayer.x <= newRight) {
					leftBoundary = newLeft; rightBoundary = newRight-vw;
					targetX = clamp(oPlayer.x-vw/2, leftBoundary, rightBoundary);
					break;
				}
			}
			//deactivate everything except for key objects or objects which should
			//be left on to not cause problems
			//then activate te region
			instance_deactivate_all(true);
			instance_activate_object(oPersistent);
			instance_activate_object(oBg);
			instance_activate_object(oCoinLight);
			instance_activate_object(oBelowLight);
			instance_activate_object(oBulletLight);
			instance_activate_object(oPlayer);
			instance_activate_object(oBorder);
			//instance_activate_object(oBulletCannon);
			//note: region checks intersections of bounding boxes,
			//since falling/moving platforms have sNone if the player's not above them,
			//they wont activate so you need to activate them manually
			instance_activate_object(oFallingPlatform);
			instance_activate_object(oMovingPlatform);
			//activate region (note: things on the border aren't activated)
			instance_activate_region(leftBoundary, targetY, rightBoundary-leftBoundary+vw, vh, true);
		}
		//reset enemies after the new ones are active
		resetArea(); 
	}
}
camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake), targetY + random_range(-shake, shake));
yLevel = targetY/vh;