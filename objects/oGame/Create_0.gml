a = array_create(16, infinity);
shake = 0;

targetX = 0; 
targetY = 0;
lvl = real(string_digits(room_get_name(room)));
targetLvl = 0;

yLevel = -1; leftBoundary = 0; rightBoundary = 0;
resetAttempts = false;
