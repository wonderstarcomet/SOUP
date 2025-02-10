//function editor_make_image(sprite) {
//    var uvs = sprite_get_uvs(sprite, 0);
//    var texture = sprite_get_texture(sprite, 0);
    
//    return {
//        uvs: uvs,
//        texture: texture
//    };
//}

/// @function editor_create_new_editor(newEditor)
/// @desc Creates a new type of editor if it doesn't already exist
/// @arg {Asset.GMObject} newEditor
function editor_create_new_editor(newEditor) {
	
	instance_destroy(oEditorInstance);
	instance_destroy(oEditorTile);
	
	// Make the thing
    instance_create_depth(x, y, depth, newEditor);
}

/**
 * Saves a level made in SOUP to a file.
 * This function will run some auxillary functions that save different parts of a level (Things, tiles, etc.)
 * Stuff saved into the file are generally of the format TYPE,X,Y,IDENTIFIER.
 *
 * @param {String} levelName The name of the level.
 */
function editor_save_level() {
	
	// Begin ego timer
	var startTime = get_timer();
	
	// The default name for the saved file
	var levelName = "mylevel";
	
	// First open a file for writing
	var level = get_save_filename("Supermelon Level File (*.broth)|*.broth", levelName);
	
	var file = file_text_open_write(level);
	
	// Set the format version, open the file, and run all of the auxillary save functions
	var formatVer = "1000";
	file_text_write_string(file, formatVer);
	file_text_writeln(file);
	
	editor_archive_tiles(file);
	editor_archive_things(file);
	
	file_text_close(file);
	
	// See how long it took
	var elapsedTime = get_timer() - startTime;
	elapsedTime /= 1000;
	
	show_debug_message("Level save took " + string(elapsedTime) + " ms");
	
	
}

/**
 * Loops through all of the Things in a given mission and saves them to a file.
 * @param {Id.TextFile} 
 */
function editor_archive_things(file) {
	file_text_write_string(file, "THINGS");
	file_text_writeln(file);
	
	with (all) {
		
		// If this Thing is flagged as needing to be saved, save it to the file
		if (variable_instance_exists(self, "editorShouldSave")) {
			if (editorShouldSave) {
				var thingString = "THING" + "," + string(self.x) + "," + string(self.y) + "," + string(object_get_name(object_index));
				file_text_write_string(file, thingString);	
				file_text_writeln(file);
			}
		};
	}
	file_text_write_string(file, "END THINGS");
	file_text_writeln(file);
}

/**
 * Loops through all of the Tiles in a given mission and saves them to a file.
 * @param {Id.TextFile} 
 */
function editor_archive_tiles(file) {
	// Tiles
	file_text_write_string(file, "TILES");
	file_text_writeln(file);
	
	// Get some info that we need to reference the tileset
	var layID = layer_get_id("Tiles");
	var tileID = layer_tilemap_get_id(layID);
	
	var levelWidth = tilemap_get_width(tileID);
	var levelHeight = tilemap_get_height(tileID);
	
	for (var i = 0; i < levelWidth; i++) {
		for (var j = 0; j < levelHeight; j++) {
			
			var tile = tilemap_get(tileID, i, j);
			
			// Skip empty tiles
			if (tile == 0) {
				continue;
			}
			
			// Write the tile's info to the given file
			var tileString = "TILE" + "," + string(i) + "," + string(j) + "," + string(tile);
			file_text_write_string(file, tileString);
			file_text_writeln(file);
			
		
		}
	}
	file_text_write_string(file, "END TILES");
	file_text_writeln(file);
}
	
