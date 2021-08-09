function initNotification() {
    //notifications show up at the bottom of the screen. 
    //they fade out on their own, or they can be prematurely replaced by another one
    //notifications are 'global' in the fact that they aren't stopped by state changes and their alpha is unaffected
    //by oPersistent.alpha
    //simply control it using handleNotification() running continuously
    
    notifAlpha = 0;
    notifState = 0;
    notifDuration = 0;
    
    //notification arrays: [current, destination]
    notifText = ["", ""];
    notifSpr = [undefined, undefined];
    notifImgAngle = [0, 0];
    notifImgRotateSpd = [0, 0];
}