t += 1/240; //image_angle += 0.75;
y = wave(ystart-8, ystart+8, 1.5, t);
if(place_meeting(x, y, oPlayer)) {
	snd(aGem);
	light(c_green, 1.2);
	firework(c_white, c_green);
	shrink(sGem);
	oGame.targetLvl = oGame.lvl+1; oGame.a[1] = 120; oGame.resetAttempts = true;
	var body = {
		level: oGame.lvl,
		attempts: oPersistent.attempts,
		duration: oGame.t
	}
	with(oPersistent) post = http_request("https://escape-server-1024.herokuapp.com/completions/add", "POST", headerMap, json_stringify(body));
	instance_destroy();
}