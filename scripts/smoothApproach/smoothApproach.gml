/// @param from
/// @param to
/// @param amnt (between 0 and 1)
/// @param [error=1]
function smoothApproach(from, to, amnt, error, maxChange) {
	if(is_undefined(error)) error = 1;
	if(is_undefined(maxChange)) maxChange = abs(to-from);
	var diff = to-from;
	if abs(diff) < error return to;
	else {
		if(abs(diff*amnt) < maxChange) return from+diff*amnt;
		else return from+maxChange*sign(to-from);
	}
}