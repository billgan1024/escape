//laser stuff
var xx = lengthdir_x(12, image_angle);
var yy = lengthdir_y(12, image_angle);
if(cannonState == 2)
{
	draw_line_width_color(x, y, c[1]+xx, c[2]+yy, laserWidth, c_red, c_red);
}
else if(cannonState == 1)
{
	var col = make_colour_rgb(255, 204, 204);
	draw_line_width_color(x, y, c[1]+xx, c[2]+yy, 9, col, col);
}
draw_self();