alarms = array_create(16, infinity);
switch(oGame.theme)
{
	case "blue": image_index = 0; colour = make_color_rgb(242, 152, 73);
	break;
	case "green": image_index = 1; colour = make_color_rgb(245, 86, 86);
	break;
}

grav = 0.1; 
maxGrav = 10; 