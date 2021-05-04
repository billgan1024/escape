smoke(c_orange, 60*5/spd, -0.01, true, 1);
var actualSpd = spd/4;
x += lengthdir_x(actualSpd, dir);
y += lengthdir_y(actualSpd, dir);

if(place_meeting(x, y, oGround)) 
{
	while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), oGround))
	{
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	instance_destroy();
	if(inView()) { audio_stop_sound(aExplosion2); snd(aExplosion2); }
	firework(c_orange, c_orange, 0.1, 2);
}
