function resolveVerificationEmail() {
    cancelRequest();
    if(async_load[?"http_status"] == 200)  {
        //you have completed the registration process
        if(isRegistering) {
            transitionTo([gs.login, [oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text]]);
        }
        setNotification("A verification email was sent. Check your inbox for the link, or click here to re-send.", 
            sSuccessIcon, infinity, [sendVerificationEmail, [false]]);
    } else if(isRegistering) {
        transitionTo([gs.login, [oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text]]);
        setNotification("An unknown error occured during the login process. Try signing in again.",
        sErrorIcon, 4);
    } else if(async_load[?"http_status"] == 400) {
        var knownCodes = ["TOO_MANY_ATTEMPTS_TRY_LATER"];
        switch(arrayFind(knownCodes, res[$"error"][$"message"])) {
            case 0:
                setNotification("Too many attempts. Please try again later.", sErrorIcon, 4);
            break;
            case -1:
                setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
            break;
        }
    } else setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
}
