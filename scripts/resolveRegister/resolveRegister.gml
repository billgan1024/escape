function resolveRegister() {
    cancelRequest();
    if(async_load[?"http_status"] == 200) {
        //wait until everything has resolved before doing stuff
        //keep the user on the register page while you send a login request
        sendLogin(oPersistent.textboxIDs[|1].text, oPersistent.textboxIDs[|2].text);
    } else if(async_load[?"http_status"] == 400) {
        var knownCodes = ["auth/email-already-exists", "auth/invalid-password", "auth/invalid-email"];
        switch(arrayFind(knownCodes, res[$"code"])) {
            case 0: setNotification("A user with this email already exists.", sErrorIcon, 4);
            break;
            case 1: setNotification("Your password must be at least six characters long.", sErrorIcon, 4);
            break;
            case 2: setNotification("Invalid email address.", sErrorIcon, 4);
            break;
            case -1: setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
            break;
        }
        
    } else {
        setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
    }
}