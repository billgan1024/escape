function checkReleasedWallKick() {
	if(khsp > 0 && hsp+khsp < wallKickSpd/2 && input[2][in.left]) khsp /= 2;
	if(khsp < 0 && hsp+khsp > -wallKickSpd/2 && input[2][in.right]) khsp /= 2;
}