function resetArea() {
	with(oEnemy) { x = xstart; y = ystart; hsp = hspStart; }
	with(oSpike) { 
		image_angle = 0; pos = startPos; angle = startAngle;
		x = path_get_x(pathIdx, pos) + lengthdir_x(radius, angle) + offsetX;
		y = path_get_y(pathIdx, pos) + lengthdir_y(radius, angle) + offsetY;
	}
	with(oCoin) { image_angle = 0; x = xstart; t = 0; a[1] = random_range(90, 120); }
	with(oMovingPlatform) { t = 0; }
	with(oFallingPlatform) { state = 0; a[1] = random_range(40, 60); a[2] = infinity; }
	instance_destroy(oBullet);
	instance_destroy(oMissile, false);	
	with(oBulletCannon) { a[1] = delayStart; a[2] = infinity; }
	with(oMissileCannon) { 
		a[1] = delayStart; a[2] = infinity; image_angle = angleStart; 
		len = 0; laserAlpha = 0;
	}
	with(oLaserCannon) {
		state = 0; a[1] = delayStart; a[2] = infinity; t = 0; len = 0; a[3] = 8;
		image_angle = angleStart;
	}
	with(oGem) { t = 0; a[1] = random_range(15, 60); }
	with(oGemOrange) { state = 0; t = 0; a[1] = random_range(15, 60); }
}

//for testing purposes only, since this function takes a lot of time to execute
function createLevel(img) {
	var w = sprite_get_width(img); // image width
	var h = sprite_get_height(img); // image height
	var surf = surface_create(w, h); // create a surface

	surface_set_target(surf); // set the surface target
	draw_sprite(img, 0, 0, 0); // draw the image to the surface
	surface_reset_target(); // reset the surface target
	for (var i = 0; i < w; i++) { // cycle through width of image
    	for (var j = 0; j < h; j++) { // cycle through height of image
	        // get the pixel color at the given coordinates (SLOW FUNCTION, use graciously)
	        var col = surface_getpixel(surf, i, j);
	        var boundary = make_colour_rgb(0, 104, 171), ground = make_colour_rgb(22, 24, 26);
	        var player = make_colour_rgb(34, 197, 94);
			var platform = make_colour_rgb(107, 114, 128);
			var tmp = make_colour_rgb(249, 115, 22);
	        if(col == boundary) {
	        	instance_create_layer(60*i, 60*j, "Persistent", oBoundary);
	        	instance_create_layer(60*i, 60*j, "Ground", oGround);
	        }
	        else if(col == ground) instance_create_layer(60*i, 60*j, "Ground", oGround);
	        else if(col == player) instance_create_layer(60*i, 60*j, "Player", oPlayer);
	        else if(col == platform) instance_create_layer(60*i, 60*j, "Ground", oFallingPlatform);
	        else if(col == tmp) {
	        	for(var k = 0; k < 360; k += 90) {
	        		with(instance_create_layer(60*i, 60*j, "Enemies", oBulletCannon)) {
	        			image_angle = k;
	        			setCannon(120, 480, 18);
	        		}
	        	}
	        }
    	}
	}
}
