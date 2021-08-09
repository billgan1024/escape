//note that text boxes are not reachable via keyboard controls, but they still have a row and column
//so that you can grab text via menu item position
a = array_create(16, infinity);
text = ""; 
//actual text rendered
//also track position of cursor
drawText = ""; 
cursorOffset = 0;
selected = false;
label = "";

//for text boxes, use the width to scale the text downwards if the string length is too high
w = 800; h = 100;
vOffset = 9;
textCursor = false;
//whether or not you replace the text with * in drawMenu()
passwordField = false;

//default character limit
limit = 16;
flexScale = 1;