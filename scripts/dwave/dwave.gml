//dx/dt for wave
function dwave(from, to, period, t) {
	return wave(from, to, period, t+1/240)-wave(from, to, period, t);
}