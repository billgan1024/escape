function sendRegister(_email, _pass) {
    //new update: post to this cloud function so u can send all ur stuff
    //this will only create a user in the backend which will not give you an auth/refresh token automatically
    with(oHttp) {
        reqImportant = true;
        var body = {
            email: _email, 
            password: _pass,
            returnSecureToken: "true"
        }
        reqID = http_request(functionUrlPrefix + "signUp", "POST", global.headerMap, json_stringify(body));
        reqType = request.register;
        a[1] = httpTimeout*240;
        setNotification("Creating account...", sLoadingIcon);
    }
}