//collection of keyboard sequences that can be executed 
function gotoAllLevels() {
    for(var i = 20; i < 32; i++) {
        ds_queue_enqueue(autoKey, vk_enter);
        for(var j = 0; j < floor(i/8); j++) ds_queue_enqueue(autoKey, vk_down);
        for(var j = 0; j < i%8; j++) ds_queue_enqueue(autoKey, vk_right);
        ds_queue_enqueue(autoKey, vk_enter);
        ds_queue_enqueue(autoKey, vk_escape);
        ds_queue_enqueue(autoKey, vk_up);
        ds_queue_enqueue(autoKey, vk_enter);
    }
    a[5] = inputDelay*3;
}