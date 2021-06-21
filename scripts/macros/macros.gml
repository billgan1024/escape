#macro dshalign draw_set_halign
#macro dsvalign draw_set_valign
#macro dsalpha draw_set_alpha
#macro dscolour draw_set_colour
#macro dsfont draw_set_font

#macro vx camera_get_view_x(view_camera[0])
#macro vy camera_get_view_y(view_camera[0])
#macro vw 2560
#macro vh 1440

#macro gain audio_sound_get_gain

#macro fadeSpeed 0.05
#macro inputDelay 15

//global gravity
#macro grav 0.056
#macro maxGrav 6.4

//span keyword for menu items which take up the whole row/column
#macro span -1

//room transition keywords for transitionTo() (-1 represents no room change, and -2 represents a restart)
#macro sameRoom -1
#macro restartRoom -2

//text is actually scaled lower so that we can enlarge it to the original size when menu items are hovered over
#macro mainTextScale 0.92