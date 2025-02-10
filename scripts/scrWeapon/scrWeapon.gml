function Weapon(attributes, type) constructor {
	damage = attributes.damage;
	startAmmo = noone;
	maxAmmo = noone;
	ammoType = attributes.ammoType;
	fire = attributes.fire;
	cooldown = attributes.cooldown;
}

/// @function weapon_fire_bullet(owner, [bulSp], [damage], [accuracy])
/// @desc Fires one bullet. Uses the caller as its origin.
/// @arg {Id.Instance} owner
/// @arg {real} [bulSp]
/// @arg {real} [damage]
/// @arg {real} [accuracy]
function weapon_fire_bullet(owner, bulSp = 5, damage = 5, accuracy = 100, bulDir = owner.direction) {
	// Create the bullet
	var bullet = instance_create_layer(owner.x, owner.y, owner.layer, oBullet, 
	{speed : bulSp, 
	damage : damage,
	owner : owner,
	direction : bulDir});
	
	// Calculate its deviation
	bullet.direction += weapon_bullet_deviation(accuracy);
	
}

/// @function weapon_bullet_deviation(accuracy)
/// @desc Calculates the deviation of a bullet.
/// @arg accuracy
/// @returns {real} The deviation of a bullet.
function weapon_bullet_deviation(accuracy) {
	var deviation = (100 - accuracy) / 100; // Deviation factor
	var angle_offset = random_range(-deviation * 90, deviation * 90);
	
	return angle_offset;
}