function wave(from, to, period, t) {
	return (to-from)/2*sin(2*pi/period*t) + (from+to)/2;
}

