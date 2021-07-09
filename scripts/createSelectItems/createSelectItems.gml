function createSelectItems() {
    for(var i = 0; i < 4; i++) {
		for(var j = 0; j < 8; j++) {
			with(instance_create_layer(vw/2-120*3.5+120*j, 400+120*i, "Persistent", oButton)) {
				r = i; c = j;
				up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
				enter = [transitionTo, [gs.game, 0, 0, asset_get_index("level" + string(8*i+j+1)), aGame]];
				text = 8*i+j+1;
				w = string_width(text)+h_offset;
				h = string_height(text)+v_offset;
			}
		}
	}
	with(instance_create_layer(vw/2, 400+120*7, "Persistent", oButton)) {
		r = 4;
		c = span;
		up = [changeCursor, [-1, 0]];
		down = [changeCursor, [1, 0]];
		enter = oPersistent.escActions[gs.select];
		text = "Back";
		w = string_width(text)+h_offset;
		h = string_height(text)+v_offset;
	}
}

function drawSelectBackground() {
    //drawRectangleWidth(vw/2-120*5, 300, vw/2+120*5, 300+120*5, 4, alpha/5);
}