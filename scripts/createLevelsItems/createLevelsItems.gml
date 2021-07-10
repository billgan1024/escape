function createLevelsItems() {
	//customLevelPage is a global variable (we want it to persist between transitions)
    loadPage(customLevelPage);
    var labels = ["New Level", "Back"];
    var actions = [undefined, oPersistent.escActions[gs.levels]];
    for(var i = 0; i < 2; i++) {
    	with(instance_create_layer(vw/2, 400+120*(i+6), "Persistent", oButton)) {
	    	r = i+4;
			c = span;
			up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
			enter = actions[i];
			text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
		}
    }
    
}

function loadPage(page) {
    //load any particular page by simply assigning text to the existing box(can be used in an in-state transition)
    
    //first, perform a rectangular deletion 
    with(oMenuItem) {
    	if(0 <= r && r < 4 && 0 <= c && c < 4) instance_destroy();
    }
    
    var hs = 600, vs = 150;
    var maxWidth = 500;
    for(var i = 0; i < 4; i++) {
        for(var j = 0; j < 4; j++) {
            var idx = 16*page+4*i+j;
            with(instance_create_layer(vw/2-hs*1.5+hs*j, 400+vs*i, "Persistent", oButton)) {
                r = i; c = j;
                up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
				if(idx < ds_list_size(other.levelNames)) {
					//shorten the name if necessary
					var name = other.levelNames[|idx];
					if(string_width(name) > maxWidth) {
						for(var k = string_length(name)-1; k > 0; k--) {
							var tmp = string_copy(name, 1, k) + "...";
							if(string_width(tmp) <= maxWidth) {
								name = tmp; break;
							}
						}
					}
					text = name;
				}
                else text = "...";
    			w = string_width(text)+h_offset;
    			h = string_height(text)+v_offset;
            }
        } 
    }
}