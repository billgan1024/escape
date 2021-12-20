draw_self();
// if(!deactivated) draw_text(x, y-50,  oPlayer.y+30 > y && oPlayer.y-30 < y+30 && oPlayer.x+30 > x-120 && oPlayer.x-30 < x+120);
if(!deactivated) draw_text(x, y-50, string(py >= oPlayer.y+30) + " " + string(oPlayer.y+30 > y && oPlayer.y-30 < y+30 && oPlayer.x+30 > x-120 && oPlayer.x-30 < x+120));

