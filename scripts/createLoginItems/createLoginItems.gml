function createLoginItems() {
    with(instance_create_layer(vw/2, 400, "Persistent", oTextBox)) {
        label = "Username"; limit = 16;
    }
    with(instance_create_layer(vw/2, 400+180, "Persistent", oTextBox)) {
        label = "Password"; limit = 32; passwordField = true;
    }
    
    //buttons: login, signup, and quit
    var labels = ["Log In", "Register", "Quit"];
    var actions = [undefined, transitionTo, quit];
    var args = [[], [gs.register], []];
    for(var i = 0; i < 3; i++) {
        with(instance_create_layer(vw/2, 400+120*(i+4), "Persistent", oButton)) {
            r = i; 
            up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
            enter = [actions[i], args[i]];
            text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
			setItemDimensions();
        }
    }
}

function login(user, pass) {
	
}