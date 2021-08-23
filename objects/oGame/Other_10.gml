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
	if(!oPlayer.freecam) {
		//remember that [cameraX, cameraY] describes the top-left corner
		cameraX = smoothApproach(cameraX, clamp(oPlayer.x+oPlayer.cameraOffsetX-vw/2, 
		boundingBox[0], boundingBox[2]-vw), 0.01);
		
		switch(vState) {
			case "ground":
				cameraY = smoothApproach(cameraY, clamp(vLevel, 
				boundingBox[1], boundingBox[3]-vh), 0.01, 0.4);
				if(oPlayer.y < vy+360 || oPlayer.y > vy+vh-360) vState = "follow";
			break;
			
			case "follow":	
				cameraY = smoothApproach(cameraY, clamp(oPlayer.y+oPlayer-vh/2, 
				boundingBox[1], boundingBox[3]-vh), 0.01, 0.4);
				if(oPlayer.state == "ground") {
					vLevel = oPlayer.y-vh/2; vState = "ground";
				}
			break;	
		}
	}
}

camera_set_view_pos(view_camera[0], cameraX + random_range(-shake, shake), cameraY + random_range(-shake, shake));
//update camera data:
//get x and y coords of all boundaries in the room
//sort array by y coord first, then x coord
//then update the oPersistent.cameraData array (note that u can edit a lot of 'undefined' areas in a GMS2 array lmao)
//new: implement new camera system based on a collection of boundary boxes defined by
//oBoundary objects with their own room ids starting from 1
/*if(oPersistent.cameraData[lvl] == -1)
{
	var l = lvl;
	var flag = array_create(room_height/vh);
	with(oBoundary)
	{
		//append the x coord to the end of data[level][ycoord]
		//note that we can append things by assuming that the position already exists
		var yy = y/vh;
		if(!flag[yy]) {
			oPersistent.cameraData[l][yy][0] = x; flag[yy] = true;
		}
		else oPersistent.cameraData[l][yy][array_length(oPersistent.cameraData[l][yy])] = x;
	}
	//finally, sort all of the boundaries by x-coord and adjust the right boundary x-values
	for(var i = 0; i < array_length(oPersistent.cameraData[lvl]); i++) {
		oPersistent.cameraData[lvl][i] = arraySort(oPersistent.cameraData[lvl][i], true);
		for(var j = 1; j < array_length(oPersistent.cameraData[lvl][i]); j += 2) oPersistent.cameraData[lvl][i][j] += 60; 
	}
}*/

t += 1/240;
//these events are run only once, before the game deactivates everything except for the current region
//get all death locations for this level
if(oPersistent.testObjects) verifyObjects();

shake = approach(shake, 0, 0.08);
borderRadius = smoothApproach(borderRadius, oPlayer.freecam ? 30 : 0, 0.08);

/*
if(!oPlayer.dead && !oPlayer.freecam) {
	targetX = smoothApproach(vx, clamp(oPlayer.x+oPlayer.cameraOffset-vw/2, 
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
		//activate all global objects
		for(var i = 0; i < len(global.globalObjects); i++) instance_activate_object(global.globalObjects[i]);
		//activate all objects local to the entire room (thus u also need to make sure
		//they remain active)
		instance_activate_object(oCoinLight);
		instance_activate_object(oBelowLight);
		instance_activate_object(oBulletLight);
		instance_activate_object(oPlayer);	
		instance_activate_object(oBorder);
		//instance_activate_object(oBulletCannon);
		//note: region checks intersections of bounding boxes,
		//since falling/moving platforms don't have a bounding box if the player's not above them,
		//they wont activate so you need to activate them manually
		instance_activate_object(oFallingPlatform);
		instance_activate_object(oMovingPlatform);
		//activate region (note: things with bounding boxes on the border aren't activated)
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
*/