//note that array_push and array_pop are the only functions that work with structs 
function initMenu() {
	var titles = ["Play", "Level Select", "Options", "Quit"];
	//note: gamemaker won't convert functions into integer references, so u need to define all functions yourself
	//e.g. you can't put function() { game_end(); } into actions[]
	var actions = [transitTo, goForward, goForward, quit], args = [[level1], [gs.select], [gs.options], []];
	for(var i = 0; i < 4; i++) {
		//note: array_push is buggy, use dynamic allocation instead 
		//you can also pass in arrays to be assigned to the menu item later. 
		//u pass in a reference to a function (id #) in order to execute it later with oPersistent (with arguments)
		menuData[gs.menu][i] = {
		    obj: oButton,
			x: vw/2,
			y: 500+120*i,
			r: i,
			c: 0,
			up: [cursorChange, [-1, 0]],
			down: [cursorChange, [1, 0]],
			left: undefined,
			right: undefined,
			enter: [actions[i], args[i]],
			text: titles[i]
		}
	}
	for(var i = 0; i < 4; i++) {
		for(var j = 0; j < 8; j++) {
			menuData[gs.select][8*i+j] = {
				obj: oButton,
				x: vw/2-120*3.5+120*j,
				y: 400+120*i,
				r: i,
				c: j,
				up: [cursorChange, [-1, 0]],
				down: [cursorChange, [1, 0]],
				left: [cursorChange, [0, -1]],
				right: [cursorChange, [0, 1]],
				enter: [transitTo, [gs.game, asset_get_index("level" + string(8*i+j+1))]],
				text: 8*i+j+1
			}
		}
	}
	menuData[gs.select][array_length(menuData[gs.select])] = {
		obj: oButton,
		x: vw/2,
		y: 400+120*7,
		r: 4,
		c: -1,
		up: [cursorChange, [-1, 0]],
		down: [cursorChange, [1, 0]],
		left: undefined,
		right: undefined,
		enter: [goBack, []],
		text: "Back"
	}
}

function loadMenu(_gameState) {
    for(var i = 0; i < array_length(menuData[_gameState]); i++) {
        log(menuData[_gameState][i]);
    }
    for(var i = 0; i < array_length(menuData[_gameState]); i++) {
        var item = menuData[_gameState][i];
        var g = instance_create_layer(vx+item.x, vy+item.y, "Persistent", item.obj);
        with(g) {
        	r = item.r; c = item.c; up = item.up; down = item.down; left = item.left; right = item.right; 
        	enter = item.enter;
        	if(object_index == oButton) {
	            text = item.text;
	            w = string_width(item.text);
	            h = string_height(item.text);
        	} else if(object_index == oTextBox) {
	            w = 200; h = 50;
        	}
        }
    }
    checkSelected();
    log(cur.enter);	
}

function handleMenuNew() {
	//pro tip: calling a function using id.f() will have the caller as that object
	//however, using script_execute(id.f) will have the caller as the original instance which called script_execute;
	//in this case, it's oPersistent
	if(input2[in.left] && !is_undefined(cur.left)) { script_execute_ext(cur.left[0], cur.left[1]); snd(aScroll); clearPressed(); }
	if(input2[in.right] && !is_undefined(cur.right)) { script_execute_ext(cur.right[0], cur.right[1]); snd(aScroll); clearPressed(); }
	if(input2[in.up] && !is_undefined(cur.up)) { script_execute_ext(cur.up[0], cur.up[1]); snd(aScroll); clearPressed(); }
	if(input2[in.down] && !is_undefined(cur.down)) { script_execute_ext(cur.down[0], cur.down[1]); snd(aScroll); clearPressed(); }
	if(input2[in.enter] && !is_undefined(cur.enter)) { script_execute_ext(cur.enter[0], cur.enter[1]); snd(aSelect); clearPressed(); }
}


function cursorChange(dr, dc) {
	//log(object_get_name(object_index));
	r = (r+dr+row[gameState]) % row[gameState];
	c = (c+dc+col[gameState]) % col[gameState];	
	checkSelected();
}