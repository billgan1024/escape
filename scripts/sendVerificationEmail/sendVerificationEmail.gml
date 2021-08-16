//function to send a verification email
//this is called when you register and you can click the notification multiple times if you want
//assumes you already have an authToken
function sendVerificationEmail(isReg) {
    with(oHttp) {
        if(!is_undefined(isReg)) isRegistering = isReg;
        reqImportant = true;
        var body = {
            requestType: "VERIFY_EMAIL",
            idToken: authToken
        };
        reqID = http_request(apiUrlPrefix + "accounts:sendOobCode" + apiUrlSuffix, "POST", global.headerMap, json_stringify(body));
        reqType = request.verificationEmail;
        a[1] = httpTimeout*240;
        
        if(!isRegistering) setNotification("Sending verification email...", sLoadingIcon);
    }
}