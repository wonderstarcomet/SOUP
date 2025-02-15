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
	
	show_debug_message("[SOUP] Starting mission save");
	
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
	
	show_debug_message("[SOUP] mission save took " + string(elapsedTime) + " ms");
	
	
}

/**
 * Loops through all of the Things in a given mission and saves them to a file in JSON format
 * @param {Id.TextFile} 
 */
function editor_archive_things(file) {
	var thingsArray = ds_map_create();
	
	with (all) {
		
		// If this Thing is flagged as needing to be saved, save it to the file
		if (variable_instance_exists(self, "editorShouldSave")) {
			if (editorShouldSave) {
				var thingData = {
					object : object_get_name(object_index),
					x : self.x,
					y : self.y
				}
				
				ds_map_add(thingsArray, string(object_get_name(object_index)), thingData);
			}
		}
	}
	var json = json_encode(thingsArray, true);
	file_text_write_string(file, json);
	
}

/**
 * Loops through all of the Tiles in a given mission and saves them to a file.
 * @param {Id.TextFile} 
 */
function editor_archive_tiles(file) {
	
	var tilesArray = ds_map_create();
	
	// Tiles
	
	// Get some info that we need to reference the tileset
	var layID = layer_get_id("Tiles");
	var tileID = layer_tilemap_get_id(layID);
	
	var levelWidth = tilemap_get_width(tileID);
	var levelHeight = tilemap_get_height(tileID);
	
	for (var i = 0; i < levelWidth; i++) {
		for (var j = 0; j < levelHeight; j++) {
			
			// Get each tile and its metadata and store it in the tileset
			var tile = tilemap_get(tileID, i, j);
			
			var tileIsRotated = tile_get_rotate(tile);
			var tileIsFlipped = tile_get_flip(tile);
			var tileIsMirrored = tile_get_mirror(tile);
			
			// Skip empty tiles
			if (tile == 0) {
				continue;
			}
			
			var tileData = {
					xpos : i,
					ypos : j,
					tileType : tile,
					rotated : tileIsRotated,
					flipped : tileIsFlipped,
					mirrored : tileIsMirrored
					
				}
			
			ds_map_add(tilesArray, "TILE" + string(i) + string(j), tileData);
		}
	}
	
	var json = json_encode(tilesArray, true);
	file_text_write_string(file, json);
	
}
	
