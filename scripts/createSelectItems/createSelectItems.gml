function createSelectItems() {
    #region main
    for(var i = 0; i < 4; i++) {
		for(var j = 0; j < 8; j++) {
			with(instance_create_layer(vw/2-120*3.5+120*j, 400+120*i, "Persistent", oButton)) {
				r = i; c = j; other.itemIDs[#r, c] = id;
				up = [changeCursor, [-1, 0]];
				down = [changeCursor, [1, 0]];
				left = [changeCursor, [0, -1]];
				right = [changeCursor, [0, 1]];
				enter = [transitionTo, [gs.game, 0, 0, asset_get_index("level" + string(8*i+j+1)), aGame]];
				text = 8*i+j+1;
				setItemDimensions();
			}
		}
	}
	#endregion
	#region back
	with(instance_create_layer(vw/2, 400+120*7, "Persistent", oButton)) {
		r = 4; c = span; 
		//remember to fill up this row with the instance ID
		for(var i = 0; i < other.maxCol[other.gameState]; i++) other.itemIDs[#r, i] = id; 
		up = [changeCursor, [-1, 0]];
		down = [changeCursor, [1, 0]];
		enter = other.escActions[other.gameState];
		text = "Back";
		setItemDimensions();
	}
	#endregion
}

function drawSelectBackground() {
    //drawRectangleWidth(vw/2-120*5, 300, vw/2+120*5, 300+120*5, 4, alpha/5);
}