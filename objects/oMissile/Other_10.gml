if(!inBoundary()) instance_destroy();
smoke(c_orange, 60*5/spd, -0.01, true, 1);
//show_debug_message([x, y]);
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
	if(inView()) { audio_stop_sound(aExplosion2); snd(aExplosion2); }
	if(!oPlayer.dead) {
		if(point_distance(x, y, oPlayer.x, oPlayer.y) <= radius) {
			with(oPlayer) death(aExplosion);
		}
	}
	firework(c_orange, c_orange, 0.1, 2);
}
