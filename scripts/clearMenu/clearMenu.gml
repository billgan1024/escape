function clearMenu() {
	with(oMenuItem) instance_destroy(); cur = undefined; ds_grid_clear(itemIDs, undefined); ds_list_clear(textboxIDs);
}