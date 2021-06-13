dshalign(fa_left);
dsvalign(fa_bottom);
draw_text(vx+10, vy+vh+6, "Level " + string(lvl));

dshalign(fa_right);

if(oPersistent.data[?"timer"]) draw_text(vx+vw-10, vy+vh+6, "Time: " + string(t) + "s");
else draw_text(vx+vw-10, vy+vh+6, "Attempt " + string(oPersistent.attempts));

dsalpha(0.1);
draw_rectangle_width(vx, vy, vx+vw, vy+vh, borderRadius);
dsalpha(1);

dshalign(fa_center);
dsvalign(fa_middle);