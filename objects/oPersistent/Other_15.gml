/// @description press a key
if(!ds_queue_empty(autoKey)) {
	var k = ds_queue_dequeue(autoKey);
	keyboard_key_press(k); keyboard_key_release(k);
	a[5] = inputDelay*3;
} else a[5] = infinity;