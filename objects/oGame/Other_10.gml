//show_debug_message(vx);
t += 1/240;
//get all death locations for this level
if(oPersistent.receiveData && !surface_exists(surf)) {
	surf = surface_create(room_width, room_height);
	surface_set_target(surf);
	draw_clear(c_white);
	dscolour(make_color_rgb(22, 24, 26));
	with(oGround) {
		draw_rectangle(x, y, x + 60*image_xscale - 1, y + 60*image_yscale-1, false);
	}
	dscolour(c_white);
	get = http_request("http://escape-server-1024.herokuapp.com/deaths", "GET", oPersistent.headerMap, "");
	surface_reset_target();
	surface_save(surf, room_get_name(room) + ".png");
}
shake = approach(shake, 0, 0.08);
borderRadius = smoothApproach(borderRadius, oPlayer.freecam ? 30 : 0, 0.08);
if(!oPlayer.dead && !oPlayer.freecam) {
	targetX = smoothApproach(vx, clamp(oPlayer.x-vw/2, 
		leftBoundary, rightBoundary), 0.01, 0.005);
	targetY = clamp(floor(oPlayer.y/vh)*vh, 0, room_height-vh);
	
	//check if player exited the current section
	var newLevel = targetY/vh;
	//important note: left and right boundary is for the camera which has a top-left origin
	//this means that when querying the actual area for the player's location,
	//add vw to the right boundary
	if(newLevel != yLevel || oPlayer.x > rightBoundary+vw || oPlayer.x < leftBoundary) {
		//loop through all intervals at this y-level; if the player's x coord
		//falls in one of them, set the new left and right boundaries to be this interval
		for(var i = 0; i < array_length(oPersistent.cameraData[lvl][newLevel]); i += 2) {
			var newLeft = oPersistent.cameraData[lvl][newLevel][i], newRight = oPersistent.cameraData[lvl][newLevel][i+1];
			//show_debug_message(newLeft);
			//show_debug_message(newRight);
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
		//with(oDoor) { count = instance_number(oCoin); show_debug_message(count); }
		//	with(oCoin) { with(oDoor){  count++; show_debug_message(count); }  }
		//a[2] = 1;
		//reset enemies after the new ones are active
		resetArea(); 
	}
}
camera_set_view_pos(view_camera[0], targetX + random_range(-shake, shake), targetY + random_range(-shake, shake));
yLevel = targetY/vh;