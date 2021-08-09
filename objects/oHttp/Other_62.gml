log(async_load[?"id"], async_load[?"status"], async_load[?"http_status"]);

//only respond if the req id matches and our request was complete
//sometimes the status is 1 when content is being downloaded (but this event will fire again once status == 0)
//if the status is < 0, you are probably not connected to the internet. 
//status is still 0 even when an error code is returned by the server (because the HTTP request was successful)
if(reqID == async_load[?"id"]) {
    if(async_load[?"status"] == 0) {
        log(async_load[?"result"]);
        if(reqType == request.login) {
            //after the user logs in, u get auth + refresh token then pass in the auth token again to check 
            //if the email is verified
            var headerMap = ds_map_create();
            headerMap[?"Authorization"] = "Bearer " + authToken;
            reqID = http_request(functionUrlPrefix, "GET", headerMap, "");
            reqType = request.verify;
    		a[1] = httpTimeout*240;
            ds_map_destroy(headerMap);
        } else {
            switch(reqType) {
                case request.death:
                break;
                case request.completion:
                break;
                case request.register:
                with(oPersistent) {
                    //go to the login screen with the data
                    //note that we pass in an array for the new state which will contain the additional data
                    //note: a weird bug will happen if you try to use the wrong accessor, so don't do it
                    //see https://yal.cc/gamemaker-quality-structures/ for more information
                    transitionTo([gs.login, [textboxIDs[|1].text, textboxIDs[|2].text]]);
                    setNotification("Verify your email address before logging in. If you did not receive one, click this notification to re-send it.", sInfoIcon, 0, 0); 
                }
                break;
                case request.update:
                break;
                case request.verify:
                if(async_load[?"http_status"] == 403) {
                    //not verified
                    with(oPersistent) setNotification("Email verification is required to log in. Click this notification to re-send the email.", sErrorIcon, 0, 0);
                } else {
                    
                }
                break;
            }
            reqID = undefined;
            reqType = undefined;
            a[1] = infinity;   
        }
    } else if(async_load[?"status"] < 0) {
        //error fetching from the server (probably not connected to the internet)
        with(oPersistent) setNotification("Unable to connect to authentication servers. Check your internet connection or try again later.", sErrorIcon, 0, 0, 4);
        reqID = undefined;
        reqType = undefined;
        a[1] = infinity;   
    }
}


