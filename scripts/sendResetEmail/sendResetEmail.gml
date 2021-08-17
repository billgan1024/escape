function sendResetEmail() {
    with(oHttp) {
        reqImportant = true;
        var body = {
            requestType: "PASSWORD_RESET",
            email: oPersistent.textboxIDs[|0].text
        };
        reqID = http_request(apiUrlPrefix + "accounts:sendOobCode" + apiUrlSuffix, "POST", global.headerMap, json_stringify(body));
        reqType = request.resetEmail;
        a[1] = httpTimeout*240;
        
        if(!isRegistering) setNotification("Sending password reset email...", sLoadingIcon);
    }
}