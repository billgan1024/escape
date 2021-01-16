if(keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))
{
	var len = array_length(ds_map_find_value(oPersistent.buttonNames, global.gameState)[0]);
	col = (col+len-1)%len;
}

if(keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")))
{
	var len = array_length(ds_map_find_value(oPersistent.buttonNames, global.gameState)[0]);
	col = (col+1)%len;
}

if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))
{
	var len = array_length(ds_map_find_value(oPersistent.buttonNames, global.gameState));
	row = (row+len-1)%len;
}

if(keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")))
{
	var len = array_length(ds_map_find_value(oPersistent.buttonNames, global.gameState));
	row = (row+1)%len;
}

if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))
{
	switch(global.gameState)
	{
		case gs.menu:
		switch(row)
		{
			case 0: room_goto(level1); global.gameState = gs.game;
			break;
			case 1: global.gameState = gs.select;
			break;
			case 3: game_end();
			break;
		}
		break;
	}
}