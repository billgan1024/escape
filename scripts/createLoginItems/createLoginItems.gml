function createLoginItems() {
    var labels = ["Username/Email", "Password"];
    for(var i = 0; i < 2; i++) {
        with(instance_create_layer(vw/2, 400+120*i, "Persistent", oTextBox)) {
            label = labels[i];
        }
    }
    
    //buttons: login, signup, and quit
    labels = ["Log in", "Sign up", "Quit"];
    var actions = [undefined, undefined, quit];
    var args = [[], [], []];
    for(var i = 0; i < 3; i++) {
        with(instance_create_layer(vw/2, 400+120*(i+2), "Persistent", oButton)) {
            r = i; 
            up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
            enter = [actions[i], args[i]];
            text = labels[i];
			w = string_width(labels[i])+h_offset;
			h = string_height(labels[i])+v_offset;
		    log(up);
        }
    }
}