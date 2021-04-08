shake = approach(shake, 0, 0.08);
if(instance_exists(oPlayer))
{
	targetX = smoothApproach(vx, clamp(oPlayer.x - vw/2 + oPlayer.cameraOffset, 0, room_width-vw), 0.01);
	targetY =  floor(oPlayer.y/vh)*vh;
	
	//check if player's y-level changed
	var newLevel = targetY/vh;
	if(newLevel != yLevel) {
		resetArea(); 
	}
}

yLevel = targetY/vh;
camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake), targetY);