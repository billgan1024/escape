//note that array_push and array_pop are the only functions that work with structs 
function initMenu() {
	var tt = ["Play", "Level Select", "Options", "Quit"];
	for(var i = 0; i < 4; i++) {
		var item = {
		    obj: oButton,
			x: vw/2,
			y: 500+120*i,
			r: i,
			c: 0,
			text: tt[i]
		}
		array_push(menuData[gs.menu], item);
	}
	log(menuData[gs.menu]);
}

function loadMenu(_gameState) {
    for(var i = 0; i < array_length(menuData[_gameState]); i++) {
        log(menuData[_gameState][i]);
    }
    while(array_length(menuData[_gameState]) > 0) {
        var item = array_pop(menuData[_gameState]);
        var g = instance_create_layer(vx+item.x, vy+item.y, "Persistent", item.obj);
        g.r = item.r; g.c = item.c; 
        if(item.obj == oButton) {
            g.text = item.text;
            g.w = string_width(item.text);
            g.h = string_height(item.text);
        } else if(item.obj == oTextBox) {
            g.w = 200; g.h = 50;
        }
    }
}