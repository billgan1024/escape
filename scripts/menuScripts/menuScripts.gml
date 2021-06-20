//note that array_push and array_pop are the only functions that work with structs 
function initMenu() {
	//menuData = array holding all of the UI elements for every state
	menuData = array_create(gs.length, []);
	//escActions = array holding all of the functions that activate upon pressing esc, for every state
	escActions = array_create(gs.length, undefined);
	escActions[gs.select] = [transitionTo, [gs.menu, -1, -1, -1]];
	escActions[gs.options] = [transitionTo, [gs.menu, -1, -1, -1]];
	escActions[gs.game] = [teleportTo, [gs.paused]];
	escActions[gs.paused] = [teleportTo, [gs.game]];
	menuItems();
	selectItems();
	optionsItems();
	pausedItems();
}

function loadMenu(_gameState) {
	//note: all menuItems have relative coordinates; oPersistent will apply the necessary shift (+vx, +vy)
    for(var i = 0; i < array_length(menuData[_gameState]); i++) {
        log(menuData[_gameState][i]);
    }
    for(var i = 0; i < array_length(menuData[_gameState]); i++) {
        var item = menuData[_gameState][i];
        var g = instance_create_layer(item.x, item.y, "Persistent", item.obj);
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
    //log(cur.enter);	
}

function handleMenu() {
	//pro tip: calling a function using id.f() will have the caller as that object
	//however, using script_execute(id.f) will have the caller as the original instance which called script_execute;
	//in this case, it's oPersistent
	if(input[1][in.left] && !is_undefined(cur.left)) { script_execute_ext(cur.left[0], cur.left[1]); snd(aScroll); clearInput(); }
	if(input[1][in.right] && !is_undefined(cur.right)) { script_execute_ext(cur.right[0], cur.right[1]); snd(aScroll); clearInput(); }
	if(input[1][in.up] && !is_undefined(cur.up)) { script_execute_ext(cur.up[0], cur.up[1]); snd(aScroll); clearInput(); }
	if(input[1][in.down] && !is_undefined(cur.down)) { script_execute_ext(cur.down[0], cur.down[1]); snd(aScroll); clearInput(); }
	if(input[1][in.enter] && !is_undefined(cur.enter)) { script_execute_ext(cur.enter[0], cur.enter[1]); snd(aSelect); clearInput(); }
}