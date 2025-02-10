/// @function                Player()
/// @description             Create a new Player.
function Player(attributes) constructor {
	// Hacky composition to give the player all the Thing attributes
	thing = new Thing(attributes);
	
	jumpHeight = attributes.jumpHeight;
	numJumps = attributes.numJumps;
	
	
}