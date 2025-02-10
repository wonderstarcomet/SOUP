global.gamemode = GAMEMODE.EDIT;

enum GAMEMODE {
	PLAY = 1,
	EDIT = 2
}

// A list (or array, who cares) of every object that needs to do something when the gamemode switches
// i.e the player spawns when the room switches from EDIT to PLAY
subscribers = [];

/**
 * Subscribes a game object to be alerted of gamemode changes
 * @param {Asset.GMObject} obj 
 **/
function subscribe(obj) {
	array_push(subscribers, obj);
}

/// @desc Sets the gamemode and lets the subscribers know it has changed.
/// @param {Real} newMode (this should be a struct parameter for the record but Feather yells if I pass in Struct)
function super_set_gamemode(newMode) {
    global.gamemode = newMode;
    for (var i = 0; i < array_length(subscribers); i++) {
        with (subscribers[i]) {
			try {
				super_on_gamemode_change(newMode);
			}
			catch (ex) {
				show_message("Caught a non-subscribed object trying to call super_on_gamemode_change(). \n You need to define super_on_gamemode_change() in " + subscribers[i]);
			}
        }
    }
}

#region Game Setup
// We need these for the level to function
instance_create_layer(x, y, layer, SuperLevel);

#endregion