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
	//first, resolve every object's other_user0 event
	with(all) {
		//important note: even though oButton and oTextBox are children of oMenuItem, the object_index check still
		//needs to be done separately (u can't use oMenuItem here)
		
		//oPlayer: run all necessary state code + hCollision + vCollision into platforms
		if(arrayFind(global.globalObjects, object_index) == -1) {
			update();
		}
	}
	//then, resolve platform move code
	with(oHorizontalPlatform) {
		//TODO: move the player this step if they are on the platform
		//update mask: this platform only has a mask when the player is above it
		// if(oPlayer.y+30 < y+1 && oPlayer.vsp >= 0) mask_index = sPlatform; 
		// else mask_index = sNone;
		//make sure you don't move the platform before the player, otherwise the collision check might fail
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
	//then, check if the player is exiting a state and finally clear input
	with(oPlayer) {
		changeState();
		clearInput();
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
	    // 	if(gameState != gs.paused && gameState != gs.optionsGame) {
	    // 		with(all) {
		   // 		if(arrayFind(global.globalObjects, object_index) == -1) {
		   // 			event_user(15);
					// }
	    // 		}
	    // 	}
    	}
    }
}