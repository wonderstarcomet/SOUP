var mx = (mouse_x div TILE_SIZE) * TILE_SIZE;
var my = (mouse_y div TILE_SIZE) * TILE_SIZE;

if (tile_index_current != 0) {
    draw_set_color(c_white);
    draw_set_alpha(0.4);

    for (var dx = -brushSize; dx <= brushSize; dx++) {
        for (var dy = -brushSize; dy <= brushSize; dy++) {
            var tx = mx + (dx * TILE_SIZE);
            var ty = my + (dy * TILE_SIZE);

            draw_tile(tileset, tile_index_current, 0, tx, ty);
        }
    }
} else {
    draw_set_color(c_red);
    draw_set_alpha(1);

    var startX = mx - (brushSize * TILE_SIZE);
    var startY = my - (brushSize * TILE_SIZE);
    var endX = mx + (brushSize * TILE_SIZE) + TILE_SIZE;
    var endY = my + (brushSize * TILE_SIZE) + TILE_SIZE;

    draw_rectangle(startX, startY, endX, endY, true);
}
