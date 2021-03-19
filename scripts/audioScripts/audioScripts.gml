function mus(audio) {
	audio_play_sound(audio, 0, true);
}

function snd(audio) {
	audio_play_sound(audio, 0, false);	
}

function updateMusicVol() {
	for(var i = 0; i < array_length(musics); i++) {
		audio_sound_gain(musics[i], data[?"mus"]*musicGain[i]/100, 0);
	}
}

function updateSoundVol() {
	for(var i = 0; i < array_length(sounds); i++) {
		audio_sound_gain(sounds[i], data[?"sfx"]*soundGain[i]/100, 0);
	}
}
