text = ""; r = 0; c = 0; w = 0; h = 0;
//scale: scalar for showing whether the button is highlighted or not
//baseScale: the value for when the mouse isn't hovered over the button
scale = mainScale;
baseScale = mainScale;
disabled = false;

//whether r, c, and cur will move to the current item after it is clicked
willMoveCursor = true;
//custom scale factor for text (this is applied AFTER the limiting maxWidth scale is applied)
customScale = 1;

alphaScale = 1; alphaScaleTo = 1;

//note that by default, the font height is too large at the bottom, so use this to reduce the size of the bottom space
//on the selector rectangle
vOffset = 9;

//max width of the text on this button; if the text is too big, the scale will compensate for that
maxWidth = 480;

spr = undefined;
imageIndex = 0;

left = undefined;
right = undefined;
up = undefined;
down = undefined;
enter = undefined;