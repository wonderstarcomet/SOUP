#region Editor Controls
if (keyboard_check_pressed(ord("E"))) {
	tile_index_current = tile_index_min;
}

if (keyboard_check_pressed(ord("R"))) {
	editor_tile_rotate_tile();
}

if (keyboard_check_pressed(ord("F"))) {
	editor_tile_flip_tile();
}

if (keyboard_check_pressed(ord("T"))) {
	editor_tile_mirror_tile();
}

if (mouse_wheel_up()) {
	brushSize += 1;
}

if (mouse_wheel_down()) {
	brushSize -= 1;
}

if (brushSize < 0) {
	brushSize = 0;
}

if (brushSize > 5) {
	brushSize = 5;
}


#endregion

spr = sprite_get_texture(tilesetSpr, 0);
uvs = texture_get_uvs(spr);

var tileCount = tilesetInfo.tile_count;
var tilesetWidth = sprite_get_width(tilesetSpr);
var tilesetHeight = sprite_get_height(tilesetSpr);

if (imguigml_ready()) {
	
	// Create the root window
	imguigml_set_next_window_pos(1920 / 2, 1080 / 2, EImGui_Cond.Once);
	imguigml_set_next_window_size(sprite_get_width(tilesetSpr) + 50, sprite_get_height(tilesetSpr) + 50, EImGui_Cond.Once);
	imguigml_begin("Tileset");
	
	// Draw the tileset image
	imguigml_image(spr, tilesetWidth, tilesetHeight, uvs[0], uvs[1], uvs[2], uvs[3]);
	
	var tilesPerRow = sprite_get_width(tilesetSpr) / TILE_SIZE;
	
	// Shimmy the values a bit so the tiles get drawn on image right
	var startX = 8;
	var startY = 27;
	
	// Draw the tileset buttons over the tileset image itself.
	for (var i = 0; i < tilesetInfo.tile_count; i++) {
		
		var xPos = startX + (i % tilesPerRow) * TILE_SIZE;
		var yPos = startY + (i div tilesPerRow) * TILE_SIZE;

	    imguigml_set_cursor_pos(xPos, yPos);
	
		imguigml_push_style_color(EImGui_Col.Button, 255);
		
		// Make sure that when you click a tileset button, it swaps tile_index_current to that tile.
		var buttonLabel = real(i);
	    if (imguigml_button(i, TILE_SIZE, TILE_SIZE)) {
			tile_index_current = buttonLabel;
		}
	
}

// Paint a tile
	if (mouse_check_button(mb_left)) {
		if (!imguigml_is_window_focused() and !imguigml_is_window_hovered()) {
			editor_tile_paint_tile();
		}
	}
}
	
