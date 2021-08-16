/// @param notif
/// @param spr 
/// @param [duration=infinity] 
/// @param [notifFunction=undefined]
function setNotification(notif, spr, duration, func) {
    //by default, there is no duration
    if(is_undefined(duration)) duration = infinity;
    else duration *= 240;
    
    //automatically set angle and rotateSpd
    with(oPersistent) {
        notifText[1] = notif;
        notifSpr[1] = spr;
        if(spr == sLoadingIcon) { notifImgAngle[1] = 0; notifImgRotateSpd[1] = -1; }
        else { notifImgAngle[1] = 0; notifImgRotateSpd[1] = 0; }
        notifFunction[1] = func;
        notifDuration = duration;
        notifState = 1;
    }
}