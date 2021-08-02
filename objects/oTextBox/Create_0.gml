//note that text boxes are not reachable via keyboard controls, but they still have a row and column
//so that you can grab text via menu item position
a = array_create(16, infinity);
text = ""; 
//actual text rendered
drawText = ""; 
selected = false;
label = "";
r = 0; c = 0; 

//for text boxes, use the width to scale the text downwards if the string length is too high
w = 600; h = 100;
vOffset = 9;
textCursor = false;
//whether or not you replace the text with * in drawMenu()
passwordField = false;

flexScale = 1;

//default character limit
limit = 16;