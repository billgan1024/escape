if(instance_exists(oPlayer))
{
	var xx = oPlayer.x - 1280, d = mouse_x - oPlayer.x;
	var tx = clamp(xx + d, xx - maxShift, xx + maxShift), ty = oPlayer.y;
	camera_set_view_pos(view_camera[0], 
		smooth_approach(vx, clamp(tx, 0, room_width-2560), 0.01), 0);
}