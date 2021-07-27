function logDeath(lvl, xx, yy) {
	var body = {
		level: lvl,
		xpos: xx,
		ypos: yy
	}
	with(oPersistent) {
		post = http_request("https://us-central1-escape-server-32386.cloudfunctions.net/add?collection=deaths", "POST", headerMap, json_stringify(body));
	}
}