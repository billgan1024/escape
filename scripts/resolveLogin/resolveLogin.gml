function resolveLogin() {
    //obtain auth and refresh token
    //you can parse the json string into a struct
    cancelRequest();
    if(async_load[?"http_status"] == 200) {
        //get login information and now start refreshing every hour
        authToken = res[$"idToken"]; refreshToken = res[$"refreshToken"];
        //now check if the person has their email verified, or automatically send a verification email
        if(isRegistering) sendVerificationEmail();
        else sendVerify();
    } else if(async_load[?"http_status"] == 400) {
        var knownCodes = ["EMAIL_NOT_FOUND", "INVALID_PASSWORD", "USER_DISABLED"];
        //note: in the case of the struct variable not existing, res[$"error"][$"message"] will not exist (very bad error)
        if(arrayFind(knownCodes, res[$"error"][$"message"]) == -1) {
            if(isRegistering) {
                transitionTo([gs.login, [oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text]]);
                setNotification("An unknown error occured during the login process. Try signing in again.",
                sErrorIcon, 4);
            }
            else setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
        } else {
            if(!isRegistering) setNotification("Invalid email address or password.", sErrorIcon, 4);
        }
    } else {
        if(isRegistering) {
            transitionTo([gs.login, [oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text]]);
            setNotification("An unknown error occured during the login process. Try signing in again.",
            sErrorIcon, 4);
        }
        else setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
    }
}