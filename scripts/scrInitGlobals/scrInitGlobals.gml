function InitGlobals() {
	// GAME
	global.grav = 0.5;
	
	// SYSTEM
	global.res_width = 1920;
	global.res_height = 1080;
	
	window_set_size(global.res_width, global.res_height);
	surface_resize(application_surface, global.res_width, global.res_height);
	window_center();
	
}