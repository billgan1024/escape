function createRegisterItems() {
	//allow people to create a username upon registering
    with(instance_create_layer(vw/2-420, 400, "Persistent", oTextBox)) {
        label = "Username"; limit = 50; text = "pblpbl";
        updateTextboxProperties();
    }
    with(instance_create_layer(vw/2+420, 400, "Persistent", oTextBox)) {
        label = "Email"; limit = 50; text = "billgan12345@gmail.com";
        updateTextboxProperties();
    }
    with(instance_create_layer(vw/2-420, 400+180, "Persistent", oTextBox)) {
        label = "Password"; limit = 32; passwordField = true; text = "pblpbl";
        updateTextboxProperties();
    }
    with(instance_create_layer(vw/2+420, 400+180, "Persistent", oTextBox)) {
        label = "Confirm Password"; limit = 32; passwordField = true; text = "pblpbl";
        updateTextboxProperties();
    }
    
    //buttons: login, signup, and quit
    var labels = ["Register", "Log In", "Quit"];
    var actions = [[register, []], [transitionTo, [gs.login]], [quit, []]];
    for(var i = 0; i < 3; i++) {
        with(instance_create_layer(vw/2, 400+120*(i+4), "Persistent", oButton)) {
            r = i; 
            up = [changeCursor, [-1, 0]];
			down = [changeCursor, [1, 0]];
            enter = actions[i];
            text = labels[i];
			w = string_width(text)+h_offset;
			h = string_height(text)+v_offset;
			updateItemProperties();
        }
    }
}

//todo: after they register, go to the login page with their email and password already set.
//prompt them to check their email to verify it. then the user presses login to go in
//called from oPersistent
function register() {
    var _email = oPersistent.textboxIDs[|1].text;
    var _pass = oPersistent.textboxIDs[|2].text;
    var _confirmPass = oPersistent.textboxIDs[|3].text;
    
    //basic validation
    if(invalidEmail(_email)) setNotification("Enter a valid email address.", sErrorIcon, 4);
    else if(_pass != _confirmPass) setNotification("Passwords do not match.", sErrorIcon, 4);
	else if(string_length(_pass) == 0) setNotification("Enter a valid password.", sErrorIcon, 4);
    else {
        with(oHttp) {
        	isRegistering = true;
        	sendRegister(_email, _pass); 
        }
    }
}
