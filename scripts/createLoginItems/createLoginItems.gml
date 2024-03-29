//create login items
//if you were redirected from register, automatically add the new user's information
function createLoginItems(email, pass) {
	if(is_undefined(email) || is_undefined(pass)) { email = ""; pass = ""; }
	
    with(instance_create_layer(vw/2, 400, "Persistent", oTextBox)) {
        label = "Email"; limit = 50; text = email; text = "billgan12345@gmail.com";
        updateTextboxProperties();
    }
    with(instance_create_layer(vw/2, 400+180, "Persistent", oTextBox)) {
        label = "Password"; limit = 50; passwordField = true; //text = pass;
        text = "pblpbl";
        updateTextboxProperties();
    }
    
    //buttons: login, signup, and quit
    var labels = ["Log In", "Register", "Quit"];
    var actions = [[login, []], [transitionTo, [gs.register]], [quit, []]];
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


//json_encode turns maps into strings, json_stringify turns structs into strings (u need to send json as a string
//otherwise, only the struct/map reference will be sent)
//also, returnSecureToken needs to be a boolean according to firebase docs, but true evaluates to 1 (an integer)
//thus, send it as a string (wtf lol)

//login: only log them in once their email is verified
//called from oPersistent
function login() {
	//grabs username and password
	var _email = oPersistent.textboxIDs[|0].text;
	var _pass = oPersistent.textboxIDs[|1].text;
	
	//update: this button will sign the user in, then also check to make sure the email is verified
	//thus, u need to make two requests; one to make sure their password is right (if it is, give them the auth and refresh token)
	//and one to make sure their email is verified
	if(invalidEmail(_email)) setNotification("Enter a valid email address.", sErrorIcon, 4);
	else if(string_length(_pass) == 0) setNotification("Enter a valid password.", sErrorIcon, 4);
	else {
		with(oHttp) {
			isRegistering = false;
			sendLogin(_email, _pass);
		}
	}
}