//collection of keyboard sequences that can be executed 
function gotoAllLevels() {
    for(var i = 0; i < 32; i++) {
        ds_queue_enqueue(autoKey, [vk_enter, inputDelay*3]);
        for(var j = 0; j < floor(i/8); j++) ds_queue_enqueue(autoKey, [vk_down, inputDelay]);
        for(var j = 0; j < i%8; j++) ds_queue_enqueue(autoKey, [vk_right, inputDelay]);
        ds_queue_enqueue(autoKey, [vk_enter, inputDelay*12]);
        ds_queue_enqueue(autoKey, [vk_escape, inputDelay*3]);
        ds_queue_enqueue(autoKey, [vk_up, inputDelay*3]);
        ds_queue_enqueue(autoKey, [vk_enter, inputDelay*3]);
    }
    a[5] = inputDelay*3;
}

function verifyObjects() {
   with(oGround) {
        if(layer != layer_get_id("Ground")) {
            log(oGame.lvl, x, y); instance_destroy();
        }
   } 
    with(oMovingPlatform) {
        if(layer != layer_get_id("Platforms") || xstart%30 != 0 || ystart%30 != 0) {
            log(oGame.lvl, xstart, ystart); instance_destroy();
        }
    }
}