smoke(c_orange, 60*5/spd);
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);

if(place_meeting(x, y, oGround)) 
{
	while(!place_meeting(x+lengthdir_x(1, dir), y+lengthdir_y(1, dir), oGround))
	{
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	instance_destroy();
	if(inView()) snd(aExplosion2);
	firework(c_orange, c_orange, 0.1, 2);
}