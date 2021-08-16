//called by oHttp
//this verifies that the person logging in has their email verified given that they already have the credentials
//i.e. the auth token
function sendVerify() { 
	with(oHttp) {
		reqImportant = true;
	    var headerMap = ds_map_create();
	    headerMap[?"Authorization"] = "Bearer " + authToken;
	    reqID = http_request(functionUrlPrefix + "app", "GET", headerMap, "");
	    reqType = request.verify;
		a[1] = httpTimeout*240;
	    ds_map_destroy(headerMap);
	}
}