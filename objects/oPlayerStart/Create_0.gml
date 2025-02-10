// Ring 'em up so the player can be spawned properly
SuperManager.subscribe(oPlayerStart);

function super_on_gamemode_change() {
	if (global.gamemode == GAMEMODE.PLAY) {
		// Creates a player at the designated location.
		// TODO: This should be in a global file so that the state of the player is always in sync,
		// but this is just for quick testing
		var player = new Player({
			name : "Player",
			maxHp : 100,
			jumpHeight : -12,
			numJumps : 1,
			canShoot : true
		})

		instance_create_layer(x, y, layer, oPlayer, player);
	};
	
	if (global.gamemode == GAMEMODE.EDIT) {
		do {
		    instance_destroy(oPlayer);
		} until (instance_number(oPlayer) <= 0);
	}
}