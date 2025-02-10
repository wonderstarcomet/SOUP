if (imguigml_ready()) {
	imguigml_set_next_window_pos(1920 / 2, 1080 / 2, EImGui_Cond.Once);
	imguigml_set_next_window_size(300, 300, EImGui_Cond.Once);
	imguigml_begin("Objects");
	
	#region Object Spawning Buttons
	imguigml_button("Spawn Goon", sprite_get_width(sGoon), sprite_get_height(sGoon));
	#endregion
}