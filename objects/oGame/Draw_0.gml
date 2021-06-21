dshalign(fa_left);
dsvalign(fa_bottom);
draw_text_transformed(vx+10, vy+vh+6, "Level " + string(lvl), mainTextScale, mainTextScale, 0);

dshalign(fa_right);

if(oPersistent.data[?"timer"]) draw_text_transformed(vx+vw-10, vy+vh+6, "Time: " + string(t) + "s", mainTextScale, mainTextScale, 0);
else draw_text_transformed(vx+vw-10, vy+vh+6, "Attempt " + string(oPersistent.attempts), mainTextScale, mainTextScale, 0);

dsalpha(0.1);
draw_rectangle_width(vx, vy, vx+vw, vy+vh, borderRadius);
dsalpha(1);

dshalign(fa_center);
dsvalign(fa_middle);