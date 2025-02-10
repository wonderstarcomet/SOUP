#macro TILE_SIZE 64
tilemap = layer_tilemap_get_id("Tiles");

tileset = tTileCity;
tilesetSpr = sTileCity;

tilesetInfo = tileset_get_info(tileset);

tile_index_current = 1;
tile_index_min = 0;
tile_index_max = tilesetInfo.tile_count;

/* 
	Defines the radius in which tiles are drawn.
	i.e, a radius of 0 is 1x1, but a radius of 1 is 3x3
	(-1, 0, +1 offsets)
*/
brushSize = 0;

function editor_tile_paint_tile() {
    var mx = mouse_x div TILE_SIZE;
    var my = mouse_y div TILE_SIZE;

    // Loop through a 3x3 grid (-1, 0, +1 offsets)
    for (var dx = -brushSize; dx <= brushSize; dx++) {
        for (var dy = -brushSize; dy <= brushSize; dy++) {
            var tx = mx + dx;
            var ty = my + dy;

            tilemap_set(tilemap, tile_index_current, tx, ty);
        }
    }
}

function editor_tile_rotate_tile() {
	var layID = layer_get_id("Tiles");
	var mapID = layer_tilemap_get_id(layID);
	var mx = tilemap_get_cell_x_at_pixel(mapID, mouse_x, mouse_y);
	var my = tilemap_get_cell_y_at_pixel(mapID, mouse_x, mouse_y);
	
	var data = tilemap_get(mapID, mx, my);
	var boolean = !tile_get_rotate(data);
	
	data = tile_set_rotate(data, boolean);
	tilemap_set(mapID, data, mx, my);
}

function editor_tile_flip_tile() {
	var layID = layer_get_id("Tiles");
	var mapID = layer_tilemap_get_id(layID);
	var mx = tilemap_get_cell_x_at_pixel(mapID, mouse_x, mouse_y);
	var my = tilemap_get_cell_y_at_pixel(mapID, mouse_x, mouse_y);
	
	var data = tilemap_get(mapID, mx, my);
	var boolean = !tile_get_flip(data);
	
	data = tile_set_flip(data, boolean);
	tilemap_set(mapID, data, mx, my);
}

function editor_tile_mirror_tile() {
	var layID = layer_get_id("Tiles");
	var mapID = layer_tilemap_get_id(layID);
	var mx = tilemap_get_cell_x_at_pixel(mapID, mouse_x, mouse_y);
	var my = tilemap_get_cell_y_at_pixel(mapID, mouse_x, mouse_y);
	
	var data = tilemap_get(mapID, mx, my);
	var boolean = !tile_get_mirror(data);
	data = tile_set_mirror(data, boolean);
	tilemap_set(mapID, data, mx, my);
}