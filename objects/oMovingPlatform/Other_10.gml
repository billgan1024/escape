//update mask: this platform only has a mask when the player is above it
if(oPlayer.y+30 < y+1 && oPlayer.vsp >= 0) mask_index = sPlatform; 
else mask_index = sNone;
t += 1/240;
x = wave(xstart-60*radius, xstart+60*radius, period, t*(flip ? -1 : 1));
hsp = dwave(xstart-60*radius, xstart+60*radius, period, t)*(flip ? -1 : 1);