a = array_create(16, infinity);	
//create effects for the bg 
//offsetX, Y: overall offset caused by parallax and the natural movement to the right
offsetX = 0;
offsetY = 0;
bgWidth = sprite_get_width(sBg2);
bgHeight = sprite_get_height(sBg2);
//speedoffset: increases the overall offset each step
speedOffset = 0;
bgSpd = 0.15;
alpha = 0.1;
drawBg = true;