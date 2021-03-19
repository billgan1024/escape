shake = approach(shake, 0, 0.08);
if(instance_exists(oPlayer))
{
	targetX = smoothApproach(vx, clamp(oPlayer.x - vw/2 + oPlayer.cameraOffset, 0, room_width-vw), 0.01);
	targetY = smoothApproach(targetY, clamp(floor(oPlayer.y/vh)*vh, 0, room_height/vh-1), 0.04);
}
camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake), targetY + random_range(-shake, shake));