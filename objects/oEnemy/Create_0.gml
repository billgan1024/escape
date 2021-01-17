grav = 0.1; 
maxGrav = 10; 

hsp = 0;
khsp = 0;
vsp = 0;
kvsp = 0;

fireAngle = 0;
fireDelay = 360;
bulletSpeed = 16;
triple = false;

moveSpd = 0;
dir = 1;

alarms = array_create(16, infinity);

switch(oGame.theme)
{
	case "blue": colour = make_color_rgb(242, 152, 73);
	break;
	case "green": colour = make_color_rgb(245, 86, 86);
	break;
}
image_blend = colour;
