function handleMenu() {
	//pro tip: calling a function using id.f() will have the caller as that object
	//however, using script_execute(id.f) will have the caller as the original instance which called script_execute;
	//in this case, it's oPersistent
	//after every interaction, update the cursor if necessary
	if(input[1][in.left] && !is_undefined(cur.left)) { script_execute_ext(cur.left[0], cur.left[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.right] && !is_undefined(cur.right)) { script_execute_ext(cur.right[0], cur.right[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.up] && !is_undefined(cur.up)) { script_execute_ext(cur.up[0], cur.up[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.down] && !is_undefined(cur.down)) { script_execute_ext(cur.down[0], cur.down[1]); snd(aScroll); checkSelected(); clearInput(); }
	if(input[1][in.enter] && !is_undefined(cur.enter)) { script_execute_ext(cur.enter[0], cur.enter[1]); snd(aSelect); checkSelected(); clearInput(); }
}