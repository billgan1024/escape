//update mask: this platform only has a mask when the player is above it
if(instance_exists(oPlayer)) {
	if(oPlayer.y+30 < y+1) mask_index = sPlatform; else mask_index = sNone;
	if(place_meeting(x, y-1, oPlayer)) {
		
	}
}
else mask_index = sNone;
t += 1/240;
x = wave(xstart-60*radius, xstart+60*radius, duration, t);
hsp = dwave(xstart-60*radius, xstart+60*radius, duration, t);