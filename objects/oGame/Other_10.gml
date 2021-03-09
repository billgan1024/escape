shake = approach(shake, 0, 0.1);
if(instance_exists(oPlayer))
{
	targetX = smooth_approach(vx, clamp(oPlayer.x - 1280 + oPlayer.cameraOffset, 0, room_width-2560), 0.01);
	//actualTargetX = smooth_approach(actualTargetX, targetX, 0.4);
	targetY = 0;
}
camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake),
targetY + random_range(-shake, shake));
