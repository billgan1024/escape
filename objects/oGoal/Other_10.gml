image_blend = make_colour_rgb(r, g, b);
r = smooth_approach(r, 98, 0.02);
g = smooth_approach(g, 217, 0.02);
b = smooth_approach(b, 107, 0.02);

if(alarms[1] == infinity && place_meeting(x, y, oPlayer))
{
	audio_play_sound(aComplete, 0, false);
	r = 35; g = 140; b = 44;
	alarms[1] = 240;
}