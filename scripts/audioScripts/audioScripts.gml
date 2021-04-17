function mus(audio) {
	return audio_play_sound(audio, 0, true);
}

function snd(audio) {
	return audio_play_sound(audio, 0, false);	
}

function updateMusicVol() {
	for(var i = 0; i < array_length(musics); i++) {
		//data[mus] = master music volume
		//then scale it by the original gain for every audio file
		audio_sound_gain(musics[i], data[?"mus"]*musicGain[i]/100, 0);
	}
}

function updateSoundVol() {
	for(var i = 0; i < array_length(sounds); i++) {
		//data[sfx] = master sounds volume
		//then scale it by the original gain for every audio file
		audio_sound_gain(sounds[i], data[?"sfx"]*soundGain[i]/100, 0);
	}
}
