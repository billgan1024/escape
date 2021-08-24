/// @param from
/// @param to
/// @param amnt (between 0 and 1)
/// @param [error=1]
/// @param [minChange=error]
/// @param [maxChange]
function smoothApproach(from, to, amnt, error, minChange, maxChange) {
	if(is_undefined(error)) error = 1;
	if(is_undefined(minChange)) minChange = error;
	if(is_undefined(maxChange)) maxChange = abs(to-from);
	var diff = to-from;
	if abs(diff) < error return to;
	else {
		if(abs(diff*amnt) > maxChange) return from+maxChange*sign(to-from);
		else if(abs(diff*amnt) < minChange) return from+minChange*sign(to-from);
		else return from+diff*amnt;
	}
}