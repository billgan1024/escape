function death(audio) {
	snd(audio); dead = true; image_alpha = 0;
	firework(c_white, c_white);
	shrink(sPlayer);
	oGame.shake = 10;
	//only reset the level if u haven't collected the gem yet
	if(oGame.a[1] == infinity) {
		oGame.targetLvl = oGame.lvl;
		oGame.a[1] = 120;
		var body = {
			level: oGame.lvl,
			xpos: x,
			ypos: y
		}
		with(oPersistent) {
			if(transmitData) post = http_request("https://escape-server-1024.herokuapp.com/deaths/add", "POST", headerMap, json_stringify(body));
		}
	}
}