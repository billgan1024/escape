function drawHitbox() {
	draw_line(bbox_left, bbox_top, bbox_right, bbox_top);
	draw_line(bbox_left, bbox_top, bbox_left, bbox_bottom);
	draw_line(bbox_right, bbox_top, bbox_right, bbox_bottom);
	draw_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom);
}
