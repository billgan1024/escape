/// @param notif
/// @param spr 
/// @param angle 
/// @param rotateSpd 
/// @param [duration=infinity] 
function setNotification(notif, spr, angle, rotateSpd, duration) {
    //by default, there is no duration
    if(is_undefined(duration)) duration = infinity;
    else duration *= 240;
    
    if(is_undefined(angle)) angle = 0;
    if(is_undefined(rotateSpd)) rotateSpd = 0;
    notifText[1] = notif;
    notifSpr[1] = spr;
    notifImgAngle[1] = angle; 
    notifImgRotateSpd[1] = rotateSpd;
    
    notifDuration = duration;
    notifState = 1;
}