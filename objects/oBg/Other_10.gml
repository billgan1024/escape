offset = ((-vx*3/4 % 1920) + 1920 + speedOffset) % 1920;
speedOffset += bgSpd*(room == menu ? 4 : 1);