if (imguigml_ready()) {
	
	 if (imguigml_begin_main_menu_bar()) {
        
        if (imguigml_begin_menu("File")) {
            if (imguigml_menu_item("Save Mission...")) { editor_save_level(); };
			
			if (imguigml_menu_item("Load Mission...")) { get_open_filename("Supermelon Mission Format (.broth) | *.broth", "") };
			
			imguigml_end_menu();
			
        }
        
        if (imguigml_begin_menu("Help")) {
            if (imguigml_menu_item("About SOUP")) {
				show_message_async("SOUP: A World Editor For GameMaker, Version 0.01 \n \n Powered By Sweet Melony Goodness(tm), Being God's Strongest Insomniac, Sinful Quantities of Alcohol, etc. \n \n Special thanks to IMGui and its love of silent failures.");
				
            }
        }
    
    }

	
	imguigml_set_next_window_size(250, 500, EImGui_Cond.Once);
	imguigml_begin("Toolbox");
	
	if(imguigml_button("Tile Mode", 110, 20)) {
		editor_create_new_editor(oEditorTile);
	}
	
	if(imguigml_button("Objects Mode", 110, 20)) {
		editor_create_new_editor(oEditorInstance);
	}
	
	if(imguigml_button("Edit Mission", 110, 20)) {
		
	}
	
	if(imguigml_button("Toggle Gamemode", 110, 20)) {
		if (global.gamemode == GAMEMODE.PLAY) {
			SuperManager.super_set_gamemode(GAMEMODE.EDIT);
		}
		else if (global.gamemode == GAMEMODE.EDIT) {
			SuperManager.super_set_gamemode(GAMEMODE.PLAY);
		}
	}
	
	var gameModeText = "Play";
	
	if (global.gamemode == GAMEMODE.PLAY) { gameModeText = "PLAY"; };
	if (global.gamemode == GAMEMODE.EDIT) { gameModeText = "EDIT"; };
	
	imguigml_text(gameModeText);
	
	if (instance_exists(oEditorTile)) {
		imguigml_text("E = Erase");
		imguigml_text("R = Rotate Tile (moused over a tile)");
		imguigml_text("F = Flip Tile (moused over a tile)");
		imguigml_text("T = Mirror Tile (moused over a tile)");
	}
	
	//var graphic_data = editor_make_image(sPlayerIdle);
	//var uvs = graphic_data.uvs;
	//var texture = graphic_data.texture;

	//imguigml_image_button(texture, 156, 172, uvs[0], uvs[1], uvs[2], uvs[3]);
	
}
