t += 1/240;
//these events are run only once, before the game deactivates everything except for the current region
//get all death locations for this level
if(oPersistent.testObjects) verifyObjects();

//note that under normal circumstances, it is ill-advised to only start updating on step 0
//however, it seems that in gamemaker's underlying implementation, 
//create events are run in the same step that you're switching rooms.
//then, update is run before draw.
//check when the player leaves the section
if(!oPlayer.dead) {
	if(is_undefined(boundingBox) || oPlayer.x < boundingBox[0] || oPlayer.x > boundingBox[2] || oPlayer.y < boundingBox[1] || oPlayer.y > boundingBox[3]) {
		//go into another room, otherwise u die
		var newArea = false;
		for(var i = 0; i < len(boundaries); i++) {
			if(oPlayer.x >= boundaries[i][0] && oPlayer.x <= boundaries[i][2] && oPlayer.y >= boundaries[i][1] && oPlayer.y <= boundaries[i][3]) {
				//go to this new area	
				boundingBox[0] = boundaries[i][0];
				boundingBox[1] = boundaries[i][1];
				boundingBox[2] = boundaries[i][2];
				boundingBox[3] = boundaries[i][3];
				//instantly snap (also reset the offset)
				oPlayer.cameraOffsetX = 0; oPlayer.cameraOffsetY = 0;
				cameraX = clamp(oPlayer.x+oPlayer.cameraOffsetX-vw/2, boundingBox[0], boundingBox[2]-vw);
				cameraY = clamp(oPlayer.y+oPlayer.cameraOffsetY-vh/2, boundingBox[1], boundingBox[3]-vh);
				//deactivate everything except for key objects or objects which should
				//be left on to not cause problems
				//then activate te region
				instance_deactivate_all(true);
				//activate all global objects
				for(var i = 0; i < len(global.globalObjects); i++) instance_activate_object(global.globalObjects[i]);
				//activate all objects local to the entire room (thus u also need to make sure
				//they remain active)
				instance_activate_object(oCoinLight);
				instance_activate_object(oBelowLight);
				instance_activate_object(oBulletLight);
				instance_activate_object(oBorder);
				//instance_activate_object(oBulletCannon);
				//note: region checks intersections of bounding boxes,
				//since falling/moving platforms don't have a bounding box if the player's not above them,
				//they wont activate so you need to activate them manually
				instance_activate_object(oFallingPlatform);
				instance_activate_object(oMovingPlatform);
				//activate region (note: things with bounding boxes on the border aren't activated)
				instance_activate_region(boundingBox[0], boundingBox[1], boundingBox[2]-boundingBox[0], boundingBox[3]-boundingBox[1], true);
				//reset enemies after the new room is active
				resetArea(); 
				newArea = true; 
				log("new area:", boundingBox);
				break;
			}
		}	
		if(!newArea) {
			with(oPlayer) death(aSplat);
		}
	}
	//now, update camera position if the player isn't controlling it 
	if(oPlayer.state != "freecam") {
		//remember that [cameraX, cameraY] describes the top-left corner
		cameraX = smoothApproach(cameraX, clamp(oPlayer.x+oPlayer.cameraOffsetX-vw/2, 
		boundingBox[0], boundingBox[2]-vw), 0.01, 0.001);
		switch(vState) {
			case "ground":
				if(oPlayer.state == "ground") vLevel = oPlayer.y-vh/2;
				cameraY = smoothApproach(cameraY, clamp(vLevel, 
				boundingBox[1], boundingBox[3]-vh), 0.01, 0.001);
				if(oPlayer.y < vy+vSection || oPlayer.y > vy+vh-vSection) vState = "follow";
			break;
			
			case "follow":	
				cameraY = smoothApproach(cameraY, clamp(oPlayer.y+oPlayer.cameraOffsetY-vh/2, 
				boundingBox[1], boundingBox[3]-vh), 0.01, 0.001);
				//if(oPlayer.state == "ground") vState = "ground";
			break;	
			
			case "disabled":
				//only approach the current v-level; never change it 
				cameraY = smoothApproach(cameraY, clamp(vLevel, 
				boundingBox[1], boundingBox[3]-vh), 0.01, 0.001);
			break;
		}
	}
}
camera_set_view_pos(view_camera[0], cameraX + random_range(-shake, shake), cameraY + random_range(-shake, shake));

shake = approach(shake, 0, 0.08);
borderRadius = smoothApproach(borderRadius, oPlayer.state == "freecam" ? 30 : 0, 0.08);