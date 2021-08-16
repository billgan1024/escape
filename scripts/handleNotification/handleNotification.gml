function handleNotification() {
    notifImgAngle[0] = (notifImgAngle[0] + notifImgRotateSpd[0] + 360) % 360;
    switch(notifState) {
        case 0: 
    	notifAlpha = approach(notifAlpha, 0, fadeSpeed);
    	break;
        case 1:
    	notifAlpha = approach(notifAlpha, 0, fadeSpeed);
    	if(notifAlpha == 0) {
    	    //assign the next state to the current state
    	    notifText[0] = notifText[1];
    	    notifSpr[0] = notifSpr[1];
    	    notifImgAngle[0] = notifImgAngle[1];
    	    notifImgRotateSpd[0] = notifImgRotateSpd[1];
    	    notifFunction[0] = notifFunction[1];
    		notifState++;
    	}
    	break;
    	case 2: 
    	notifAlpha = approach(notifAlpha, 1, fadeSpeed);
    	if(notifAlpha == 1) {
    	    a[6] = notifDuration;
    	    notifState++;
    	}
    	break;
    }
}