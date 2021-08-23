offsetX = ((-vx*3/4 % bgWidth) + bgWidth + speedOffset) % bgWidth;
offsetY = ((-vy*3/4 % bgHeight) + bgHeight) % bgHeight;
speedOffset += bgSpd*(room == menu ? 3 : 1);