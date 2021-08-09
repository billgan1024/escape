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
function register() {
	var _email = oPersistent.textboxIDs[|1].text;
	var _pass = oPersistent.textboxIDs[|2].text;
	var _confirmPass = oPersistent.textboxIDs[|3].text;
	
	//basic validation
	if(string_pos("@", _email) < 2 || string_length(_email) < 3) setNotification("Enter a valid email address.", sErrorIcon, 0, 0, 4);
	else if(_pass != _confirmPass) setNotification("Passwords do not match.", sErrorIcon, 0, 0, 4);
	else {
		with(oHttp) {
			//new update: post to this cloud function so u can send all ur stuff
			//this will only create a user in the backend which will not give you an auth/refresh token automatically
			var body = {
				email: _email, 
				password: _pass,
				returnSecureToken: "true"
			}
			
			reqID = http_request(functionUrlPrefix + "signUp", "POST", global.headerMap, json_stringify(body));
			reqType = request.register;
			a[1] = httpTimeout*240;
		}
		setNotification("Creating account...", sLoadingIcon, 0, -1);
	}
}