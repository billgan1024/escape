if(oPersistent.receiveData && !surface_exists(surf)) getDeathLocations();
dshalign(fa_left);
dsvalign(fa_bottom);
draw_text_transformed(vx+10, vy+vh+6, "Level " + string(lvl), mainScale, mainScale, 0);

dshalign(fa_right);

if(oPersistent.data[?"timer"]) draw_text_transformed(vx+vw-10, vy+vh+6, "Time: " + string(t) + "s", mainScale, mainScale, 0);
else draw_text_transformed(vx+vw-10, vy+vh+6, "Attempt " + string(oPersistent.attempts), mainScale, mainScale, 0);

drawRectangleWidth(vx, vy, vx+vw, vy+vh, borderRadius, 0.1);

dshalign(fa_center);
dsvalign(fa_middle);