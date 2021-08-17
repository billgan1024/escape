log("HTTP request received:", "ID", async_load[?"id"], "Status",  async_load[?"status"], "Code", async_load[?"http_status"]);

//only respond if the req id matches and our request was complete
//sometimes the status is 1 when content is being downloaded (but this event will fire again once status == 0)
//if the status is < 0, you are probably not connected to the internet. 
//status is still 0 even when an error code is returned by the server (because the HTTP request was successful)
if(reqID == async_load[?"id"]) {
    if(async_load[?"status"] == 0) {
    	res = json_parse(async_load[?"result"]); log(res);
        //this request finished, so reset the request variables now
        switch(reqType) {
            case request.death:
            break;
            case request.completion:
            break;
            case request.login: resolveLogin();
            break;
		    case request.register: resolveRegister();
		    break;
            case request.update:
            break;
            case request.verify: resolveVerify();
            break;
            case request.verificationEmail: resolveVerificationEmail();
            break;
            case request.resetEmail: resolveResetEmail();
            break;
        }
    } else if(async_load[?"status"] < 0) {
        //error fetching from the server (probably not connected to the internet)
        //note that we set oPersistent.canInteract separately from the request functions
        cancelRequest();
        setNotification("Unable to connect to authentication servers.", sErrorIcon, 4);
    }
} else if(refreshID == async_load[?"id"]) {
    
    //get the new details, or immediately sign out the user if there is an error
}
