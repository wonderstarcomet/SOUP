/// @function                Thing(attributes)
/// @description             Create a new Thing with the given parameters.
/// @param {struct}			 attributes    The struct of attributes given to this Thing.
function Thing(attributes) constructor {
	
	// There's been some horrible disaster
	if (!is_struct(attributes)) {
		show_error("Invalid attributes passed to Thing: " + string(attributes), true);
	}

	// Thing Attributes
	name = variable_struct_exists(attributes, "name") ? attributes.name : "John Noname";
	maxHp = variable_struct_exists(attributes, "maxHp") ? attributes.maxHp : 69;
	canShoot = variable_struct_exists(attributes, "canShoot") ? attributes.canShoot : true;
	hp = maxHp;
	
	vsp = 0;
	hsp = 0;
	
	function thing_damage(dmg) {
		hp -= dmg;
		
		if (hp < 0) {
			thing_kill();
		}
	}
	
	function thing_kill() {
		instance_destroy();
	}
	
	function thing_print_info() {
		return "[Name: " + name + "]" +
			   "[maxHp: " + maxHp + "]" +
			   "[Flags: " + "Damageable: " + canShoot + "]"; 
	}
	
}