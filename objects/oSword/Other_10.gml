image_alpha -= 0.05;
if(image_alpha == 0) instance_destroy();
if(instance_exists(oPlayer))
{
	x = oPlayer.x;
	y = oPlayer.y;
}