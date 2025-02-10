fsm = new SnowState("idle");
// https://github.com/sohomsahaun/SnowState/wiki/Event

fsm.add("idle", {
    enter: function() {
      sprite_index = sPlayerIdle;
	  //thing.hsp = 0;
    },
    step: function() {
      if (input_check("left")) || (input_check("right")) {
        fsm.change("walk");
      }
	  if (input_check("jump")) {
		if (onGround) {
			fsm.change("jump");
		}
		
		if (!onGround) and (thing.vsp > 0) {
			fsm.change("fall");
		}
		
		
	  }
	  
    },
    draw: function() {
      draw_self();
    }
  });
  
fsm.add("walk", {
    enter: function() {
      sprite_index = sPlayerIdle;
    },
    step: function() {
	// Go back to idle if we stop enough
	if (abs(thing.hsp) < 1) and (dir == 0) {
		fsm.change("idle");
	}
	
	if (input_check("jump")) {
		if (onGround) {
			fsm.change("jump");
		}
	}
	
	if (thing.vsp > 0) {
			fsm.change("fall");
		}
	
	if (input_check("down")) {
		fsm.change("dodge");
	}
	
    },
    draw: function() {
      draw_self();
    }
  });
  
fsm.add("jump", {
    enter: function() {
      sprite_index = sPlayerIdle;
	  thing.vsp = jumpHeight;
    },
    step: function() {
		
		if (thing.vsp < 0) && (!input_check("jump")) {
			thing.vsp = max(thing.vsp, jumpHeight / 4);
		}
		
		if (!onGround) and (thing.vsp > 0) {
			fsm.change("fall");
		}
		
		
    },
  });

fsm.add("fall", {
    enter: function() {
      sprite_index = sPlayerIdle;
    },
    step: function() {
		if (onGround) and (dir != 0) {
			fsm.change("walk");
		}
		
		if (onGround) and (dir == 0) {
			fsm.change("idle");
		}
	
    },
    draw: function() {
      draw_self();
    }
  });
  
  
fsm.history_enable();

/// @function player_check_walljump()
/// @description Check if the player is able to do a walljump and perform it if they are.
//function player_check_walljump() {
//	// Do a walljump if we're next to a wall
//		var wallRight = place_meeting(x + 1, y, collides);
//		var wallLeft = place_meeting(x - 1, y, collides);
		
//		if (wallRight) and (input_check_pressed("jump")) {
//			thing.hsp = -20;
//			thing.vsp = -12;	
//		}
		
//		if (wallLeft) and (input_check_pressed("jump")) {
//			thing.hsp = 20;
//			thing.vsp = -12;
//		}
//}