/// @description set state to active 
if(inView()) { audio_stop_sound(aLaser); snd(aLaser); }
state = 1; image_index = 1;
a[2] = delayActive;
a[1] = infinity;