/// @param from
/// @param to
/// @param amnt (between 0 and 1)
/// @param [error=1]
function smoothApproach(from, to, amnt, error) {
	if(is_undefined(error)) error = 1;
	var diff = to-from;
	if abs(diff) < error return to; else return from+diff*amnt; 
}