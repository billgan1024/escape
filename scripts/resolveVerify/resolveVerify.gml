function resolveVerify() {
    //verify is only called once you are not registering
    cancelRequest();
    if(async_load[?"http_status"] == 403) {
        setNotification("Email verification is required. If you did not receive one, click here to re-send it.",
            sErrorIcon, infinity, [sendVerificationEmail, [false]]);
    } else if(async_load[?"http_status"] == 200) {
        //sign the user in (they already verified their email)
        transitionTo(gs.menu);
        setNotification("Successfully signed in.", sSuccessIcon, 4);
    } else {
        setNotification("An unknown error occured. Please try again later.", sErrorIcon, 4);
    }
}