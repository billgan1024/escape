function createLevelsItems() {
    
    //by default, create the first page (you can define more transition states in oPersistent to load other pages
    //while remaining on the levels gamestate)
    loadPage(0);
}

function loadPage(page) {
    for(var i = 0; i < 4; i++) {
        for(var j = 0; j < 4; j++) {
            var idx = 16*page+4*i+j;
            with(instance_create_layer(vw/2-120*1.5+120*j, 400+120*i, "Persistent", oButton)) {
                r = i; c = j;
                up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
                text = idx < ds_list_size(other.levelNames) ? other.levelNames[|idx] : "...";
    			w = string_width(text)+h_offset;
    			h = string_height(text)+v_offset;
            }
        } 
    }
}