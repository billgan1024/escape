/// @description press a key
if(!ds_queue_empty(autoKey)) {
	var k = ds_queue_dequeue(autoKey);
	keyboard_key_press(k[0]); keyboard_key_release(k[0]);
	a[5] = k[1];
} else a[5] = infinity;