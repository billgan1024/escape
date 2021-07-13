function clearMenu() {
	with(oMenuItem) instance_destroy(); cur = undefined; ds_grid_clear(itemIDs, undefined);
}