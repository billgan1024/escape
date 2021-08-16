//note: login is the function called by the menuitem (from oPersistent) when it gets clicked
//all http functions are called by oHttp to make requests

function sendLogin(_email, _pass) {
	with(oHttp) {
		reqImportant = true;
		var body = {
			email: _email,
			password: _pass, 
			returnSecureToken: "true"
		}
		//note that body should be a string containing data (not just a map index)
		reqID = http_request(apiUrlPrefix + "accounts:signInWithPassword" + apiUrlSuffix, "POST", global.headerMap, json_stringify(body));
		reqType = request.login;
		a[1] = httpTimeout*240;
		
		if(!isRegistering) setNotification("Logging in...", sLoadingIcon);
	}
}