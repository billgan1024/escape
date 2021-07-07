t1 = ds_map_create();
t1[?"level"] = [{x: 1, y: 2}, {x: 2, y: 3}];
ds_map_secure_save(t1, "levels/test.dat");