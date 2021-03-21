if(count == 0) {
	image_yscale = smoothApproach(image_yscale, 0, 0.03, 0.005);
	if(image_yscale == 0) instance_destroy();
}