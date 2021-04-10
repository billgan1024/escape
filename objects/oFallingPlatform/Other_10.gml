//update mask: this platform only has a mask when the player is above it
if(state == 0 || state == 1) {
	image_alpha = 1; 
	if(oPlayer.y+30 < y+1) mask_index = sPlatform; else mask_index = sNone;
}
if(state == 1) x = random_range(xstart-15, xstart+15);
else if(state == 2) { mask_index = sNone; image_alpha = 0; }