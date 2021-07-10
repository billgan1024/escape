t1 = ds_map_create();
t1[?"enemies"] = [{x: 2, y: 3}, {x: 3, y: 4}];
ds_map_secure_save(t1, "levels/test.dat");

ds_list_add(oPersistent.levelNames, "test");

ds_list_add(oPersistent.levelNames, "way of the darkness");
ds_list_add(oPersistent.levelNames, "electroman adven v2");
ds_list_add(oPersistent.levelNames, "wwwwwwwwwwwwwwwwwwww");