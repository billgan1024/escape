function updateSelector() {
	//updates all properties of the selector, including its dimensions, vOffset, and alpha
	if(is_undefined(cur)) return;
	var spd = snap ? 1 : 0.12;
	selector[0] = smoothApproach(selector[0], cur.x, spd, 0.005);
	selector[1] = smoothApproach(selector[1], cur.y, spd, 0.005);
	selector[2] = smoothApproach(selector[2], cur.w, spd, 0.005);
	selector[3] = smoothApproach(selector[3], cur.h, spd, 0.005);
	vOffset = smoothApproach(vOffset, cur.vOffset, spd, 0.005);
	selectorAlpha = alpha/5*(r >= tr1 && r <= tr2 && c >= tc1 && c <= tc2 ? sAlpha : 1);
}

function update() {
	//a[1] = k => k steps from now, do something
	//a[0] = step, a[15] = end step
	if(variable_instance_exists(id, "a")) {
		for(var i = 1; i <= 14; i++) {
			a[i]--;
			if(a[i] <= 0) {
				event_user(i);
			}
		}
	}
	event_user(0);
}

function updateLocal() {
    //updates things that can be paused (everything in game)
	part_system_update(global.ps_above);
	part_system_update(global.ps_below); 
	//move platforms to their new location
	with(oPlatformNew) {
		if(!deactivated) {
		//move to the new location
		t += 1/240;
		if(pathIdx != -1) {
			var actualSpd = spd/path_get_length(pathIdx);
			pos += actualSpd;
			if(loop) pos = frac(pos);
			else {
				if(pos <= 0) {
					var d = -pos;	
					pos += 2*d;
					spd *= -1;
				} else if(pos >= 1) {
					var d = pos-1;	
					pos -= 2*d;
					spd *= -1;
				}
			}
			angle = (angle + angularSpd + 360) % 360;
			//add offsetX and offsetY to account for when the platform is isolated from the original path location
			//basically, this represents that the whole path is translated by that vector
			x = path_get_x(pathIdx, pos) + lengthdir_x(radius, angle) + offsetX;
			y = path_get_y(pathIdx, pos) + lengthdir_y(radius, angle) + offsetY;
		} else {
			if(waveDir == "h") x = wave(xstart-60*radius, xstart+60*radius, period, t);	
			else if(waveDir == "v") y = wave(ystart-60*radius, ystart+60*radius, period, t);
		}
		//floor for precise collisions(?)
		// x = round(x);
		// y = round(y);
		}
	}
	
	with(oPlatformNew) {
		//now pick up new entities by checking all collisions at the new location 
		//and finding out if py >= other.y+30 (the platform was below the player)
		//and set its y-value to y-30

		
		//first check player
		//accurate place_meeting check
		if(!deactivated) {
			if(!oPlayer.dead && oPlayer.platform != id &&
				//place_meeting(x, y, oPlayer)
				oPlayer.y+30 > y && oPlayer.y-30 < y+30 && oPlayer.x+30 > x-120 && oPlayer.x-30 < x+120
				&& py >= oPlayer.y+30) {
					log("picked up");
				oPlayer.y = y-30;	
				oPlayer.vsp = 0; oPlayer.vsp_frac = 0;
				oPlayer.a[2] = infinity;
				oPlayer.state = "ground";
				oPlayer.platform = id;
				oPlayer.canGlide = false;
				oPlayer.pickedUpByPlatform = true;
				// ds_list_add(carried, player);
			}
		}	
	}
	
	
	// for each entity, update their coords if they're on a platform and didn't just get picked up (and not already dead)
	with(oPlayer) {
		if(!dead && !pickedUpByPlatform && platform != noone) {
			var dx = platform.x-platform.px, dy = platform.y-platform.py;
			//move x normally
			if(place_meeting(x+dx, y, oGround))
			{
				while(!place_meeting(x+sign(dx), y, oGround)) x += sign(dx);
				dx = 0;
			}
			x += dx;
			
			//now move y
			var targetPlatform = noone;
			if(dy >= 0) targetPlatform = seekPlatform(dy);
			if(targetPlatform != noone) {
				var g = instance_place(floor(x), floor(y+dy), oGround);
				if(g != noone) {
					//blocks always have integer coordinates so this is fine
					if(g.bbox_top <= targetPlatform.y) {
						y = g.bbox_top-30; 
					} else y = targetPlatform.y-30;
				} else {
					y = targetPlatform.y-30;
					// log(targetPlatform.y-30);
				}
				dy = 0;
			} else {
				//move y normally, except if you're going to collide into something at the top, then get squished 
				//otherwise, this platform brings u to ground
				if(place_meeting(x, y+dy, oGround))
				{
					while(!place_meeting(x, y+sign(dy), oGround)) y += sign(dy);
					if(dy < 0) death(aExplosion);
					dy = 0;
				}
			}
			y += dy;
		} 		
	}
;	//update horizontal/vertical speed (distance travelled) last frame
	with(oPlatformNew) {
		if(!deactivated) {
			hsp = x-px;
			vsp = y-py;
			px = x; py = y;
		}
	}
	
	with(all) {
		if(arrayFind(global.globalObjects, object_index) == -1) {
			update();
		}
	}
	
	//then also check oPlatformNew (is the player right on top and is their vsp >= 0 so that they are on this platform now?)
	//in case of ties between platforms and ground, the platform will win and set the platform state accordingly
	with(oPlatformNew) {
		if(!deactivated && !oPlayer.dead && oPlayer.vsp >= 0 &&
			oPlayer.y == y-30 && oPlayer.x+30 > x-120 && oPlayer.x-30 < x+120) {
			//do a collision check + state update instantly
			oPlayer.vsp = 0; oPlayer.vsp_frac = 0;
			oPlayer.a[2] = infinity;
			oPlayer.state = "ground";
			oPlayer.platform = id;
			oPlayer.canGlide = false;
			// if(ds_list_find_index(carried, oPlayer.id) == -1) ds_list_add(carried, oPlayer.id);
		}
	}
	
	//finally, set picked up by platform to false 
	with(oPlayer) {
		if(!dead) pickedUpByPlatform = false;		
	}
	
	
	with(oHorizontalPlatform) {
		t += 1/240;
		with(oPlayer) {
		    if(vsp >= 0 && place_meeting(x, y+1, other) && !place_meeting(x, y, other)) {
		        //move the player by the same amount of pixels as this platform moved this frame
		        //but don't move them inside a platform lol
		        var dx = dwave(other.xstart-60*other.radius, other.xstart+60*other.radius, other.period, other.t)*(other.flip ? -1 : 1);
		        if(place_meeting(x+dx, y, oGround)) {
		            while(!place_meeting(x+sign(dx), y, oGround)) {
		                x += sign(dx);
		            }
		            dx = 0;
		        }
		        x += dx;
		    }
		}
		x = wave(xstart-60*radius, xstart+60*radius, period, t*(flip ? -1 : 1));
	}
	with(oVerticalPlatform) {
		t += 1/240;
		//move to the new position
		var dy = dwave(ystart-60*radius, ystart+60*radius, period, t)*(flip ? -1 : 1);
		//pick up the player if this object passes through
		if(dy <= 0 && place_meeting(x, y+dy, oPlayer) && !place_meeting(x, y, oPlayer)) {
		    oPlayer.state = "platform"; oPlayer.canGlide = false; oPlayer.currentPlatform = id;
		    oPlayer.y += (y+dy-30)-oPlayer.y; oPlayer.vsp = 0; 
		}
		y += dy;
	}
	
}

function updateGlobal() {
    //updates things that are persistent (persistent + menu stuff + background stuff)
	part_system_update(global.ps_bg);
	for(var i = 0; i < len(global.globalObjects); i++) with(global.globalObjects[i]) update();
}

//operate on this array by reference by using the @ accessor
//take in an update function as well (upd is a function's integer reference)
//note that upd() will still be called from the original calling instance (in this case, oPersistent)
function step() {
    time[1] += time[0]; 
    if(floor(time[1]) != floor(time[1]-time[0]))
    {
    	var rem = floor(time[1]) - floor(time[1]-time[0]);
    	repeat(rem) {
	    	if(gameState != gs.paused && gameState != gs.optionsGame) {
	    		updateLocal();
	    	}
    		updateGlobal(); 
    	}
    }
}