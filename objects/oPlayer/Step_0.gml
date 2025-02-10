fsm.step();

onGround = place_meeting(x, y + 5, collides);

thing.vsp = thing.vsp + global.grav;
dir = input_check("right") - input_check("left");

if (dir != 0) {
	thing.hsp = lerp(thing.hsp, maxHsp * dir, accel);
	} else {
		thing.hsp = lerp(thing.hsp, 0, decel);
	}

#region Accel/Decel
switch (onGround) {
    case true:
        accel = 0.2;
		decel = 0.1;
        break;
    case false:
        accel = 0.11;
		decel = 0.1;
        break;
}
#endregion

if (dir == 1) {
	direction = 0;
} else if (dir == -1) { 
	direction = 180;
}

move_and_collide(thing.hsp, 0, collides, abs(ceil(thing.hsp)));

move_and_collide(0, thing.vsp, collides);

if (array_length(move_and_collide(0, thing.vsp, collides)) > 0) {
	thing.vsp = 0;
}



// Causes a crash
// todo make a slope object
//if (onGround) and (!place_meeting(x, y + 2, oGround) and (thing.vsp > 0)) {
//	while (!place_meeting(x, y + 2, oGround)) { 
//		y += 1;
//	}
//}