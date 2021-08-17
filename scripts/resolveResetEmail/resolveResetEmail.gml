function resolveResetEmail() {
    cancelRequest();
    if(async_load[?"http_status"] == 200)  {
        setNotification("A password reset email was sent.", sSuccessIcon, 4, );
    } else if(async_load[?"http_status"] == 400) {
        var knownCodes = ["EMAIL_NOT_FOUND"];
        switch(arrayFind(knownCodes, res[$"error"][$"message"])) {
            case 0:
                setNotification("No user with that email exists.", sErrorIcon, 4);
            break;
            case -1:
                setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
            break;
        }
    } else {
        setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
    }
} 