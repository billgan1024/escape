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

function getDeathLocations() {
	surf = surface_create(room_width, room_height);
	surface_set_target(surf);
	draw_clear(c_white);
	dscolour(make_color_rgb(22, 24, 26));
	with(oGround) {
		draw_rectangle(x, y, x + 60*image_xscale - 1, y + 60*image_yscale-1, false);
	}
	dscolour(c_white);
	get = http_request("http://escape-server-1024.herokuapp.com/deaths", "GET", oPersistent.headerMap, "");
	surface_reset_target();
	surface_save(surf, + room_get_name(room) + ".png");
}
