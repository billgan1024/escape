var dir = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - 
	(keyboard_check(ord("A")) || keyboard_check(vk_left));
khsp = approach(khsp, 0, fric);
kvsp = approach(kvsp, 0, fric);
switch(state)
{
	case "ground": 
		hsp = approach(hsp, (moveSpd-abs(khsp)*3/4)*dir, runAcc);
		collision();
		if(jump)
		{
			vsp = -jumpSpd;	audio_play_sound(aJump, 0, false); state = "jump";
		}
		if(rmb)
		{
			ring(c_white);
			state = "blink"; alarms[2] = blinkTime;
			var d = point_direction(x, y, mouse_x, mouse_y);
			hsp = lengthdir_x(blinkSpd, d);
			vsp = lengthdir_y(blinkSpd, d);
		}
		if(!place_meeting(x, y+1, oGround)) {
			state = "buffer"; alarms[1] = bufferTime;	
		}
	break;
	case "jump":
		hsp = approach(hsp, (moveSpd-abs(khsp)*3/4)*dir, airAcc);
		applyGrav();
		collision();
		if(rmb)
		{
			ring(c_white);
			state = "blink"; alarms[2] = blinkTime;
			var d = point_direction(x, y, mouse_x, mouse_y);
			hsp = lengthdir_x(blinkSpd, d);
			vsp = lengthdir_y(blinkSpd, d);
		}
		if(jump)
		{
			if(place_meeting(x+1, y, oGround))
			{
				vsp = -jumpSpd;	khsp = -wallKickSpd; audio_play_sound(aJump, 0, false); 
			}
			else if(place_meeting(x-1, y, oGround))
			{
				vsp = -jumpSpd;	khsp = wallKickSpd; audio_play_sound(aJump, 0, false); 
			}
			else if(place_meeting(x, y+jumpPixels, oGround))
			{	
				vsp = -jumpSpd;	audio_play_sound(aJump, 0, false); 
			}
			else
			{
				vsp = -jumpSpd;	audio_play_sound(aJump, 0, false); state = "fall";
			}
		}
		if(place_meeting(x, y+1, oGround)) { state = "ground"; }
	break;
	case "buffer": 
		hsp = approach(hsp, (moveSpd-abs(khsp)*3/4)*dir, airAcc);
		applyGrav();
		collision();
		if(rmb)
		{
			ring(c_white);
			state = "blink"; alarms[2] = blinkTime;
			var d = point_direction(x, y, mouse_x, mouse_y);
			hsp = lengthdir_x(blinkSpd, d);
			vsp = lengthdir_y(blinkSpd, d);
		}
		if(jump)
		{
			vsp = -jumpSpd;	audio_play_sound(aJump, 0, false); state = "jump"; alarms[1] = infinity;
		}
		if(place_meeting(x, y+1, oGround)) { state = "ground"; alarms[1] = infinity; }
	break;
	case "fall":
		hsp = approach(hsp, (moveSpd-abs(khsp)*3/4)*dir, airAcc);
		applyGrav();
		collision();
		if(rmb)
		{
			ring(c_white);
			state = "blink"; alarms[2] = blinkTime;
			var d = point_direction(x, y, mouse_x, mouse_y);
			hsp = lengthdir_x(blinkSpd, d);
			vsp = lengthdir_y(blinkSpd, d);
		}
		if(jump)
		{
			if(place_meeting(x+1, y, oGround))
			{
				vsp = -jumpSpd;	khsp = -wallKickSpd; audio_play_sound(aJump, 0, false); state = "jump";
			}
			else if(place_meeting(x-1, y, oGround))
			{
				vsp = -jumpSpd;	khsp = wallKickSpd; audio_play_sound(aJump, 0, false); state = "jump";
			}
			else if(place_meeting(x, y+jumpPixels, oGround))
			{
				vsp = -jumpSpd;	audio_play_sound(aJump, 0, false); state = "jump";
			}
		}
		if(place_meeting(x, y+1, oGround)) { state = "ground"; }
	break;
	
	case "blink": 
	image_alpha = 0; smoke(c_white);//effect_create_above(ef_smoke, x, y, 0, c_white);
	collision();
	if(place_meeting(x-1, y, oGround) || place_meeting(x+1, y, oGround) || 
		place_meeting(x, y-1, oGround) || place_meeting(x, y+1, oGround))
		{
			ring(c_white); vsp *= 3/4;
			image_alpha = 1;
			state = "jump"; alarms[2] = infinity; 
		}
	break;
}


if(prevState != state)
{
	show_debug_message("state change");
}

//reset stuff
prevState = state;
jump = false;
lmb = false;
rmb = false;