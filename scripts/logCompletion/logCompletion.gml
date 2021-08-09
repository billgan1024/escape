function logCompletion(lvl, att, dur) {
	var body = {
		level: lvl,
		attempts: att,
		duration: dur 
	}
	with(oPersistent) {
		post = http_request("https://us-central1-escape-server-32386.cloudfunctions.net/add?collection=completions", "POST", global.headerMap, json_stringify(body));
	}
}