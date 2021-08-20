function resolveLogin() {
    //obtain auth and refresh token
    //you can parse the json string into a struct
    cancelRequest();
    if(async_load[?"http_status"] == 200) {
        //get login information and now start refreshing every hour
        authToken = res[$"idToken"]; refreshToken = res[$"refreshToken"]; user = oPersistent.textboxIDs[|0].text;
        //now check if the person has their email verified, or automatically send a verification email
        if(isRegistering) sendVerificationEmail();
        else sendVerify();
    } else if(isRegistering) {
        //??? error (should never happen)
        transitionTo([gs.login, [oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text]]);
        setNotification("An unknown error occured during the login process. Try signing in again.",
        sErrorIcon, 4);
    } else if(async_load[?"http_status"] == 400) {
        //note: in the case of the struct variable not existing, res[$"error"][$"message"] will not exist (very bad error)
        //note that you should not encounter any error when u are registering
        var knownCodes = ["EMAIL_NOT_FOUND", "INVALID_PASSWORD", "USER_DISABLED", "TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later."];
        switch(arrayFind(knownCodes, res[$"error"][$"message"])) {
            case -1: setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
            break;
            case 3: setNotification("Too many attempts. Please try again later.", sErrorIcon, 4);
            break;
            default: setNotification("Invalid email address or password. If you have forgotten your password, click this to send a reset link.",
            sErrorIcon, infinity, [sendResetEmail, []]);
            break;
        }
    } else setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
}