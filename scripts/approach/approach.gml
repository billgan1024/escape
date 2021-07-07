/// @param from
/// @param to
/// @param amnt (absolute value) 
function approach(from, to, amnt) {
	if (from < to) { from += amnt; if (from > to) return to; }
	else { from -= amnt; if (from < to) return to; }
	return from;
}

