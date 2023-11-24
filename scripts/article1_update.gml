// CAUTION: This is an unedited placeholder. Some things will not work as expected.

// article1_update - runs every frame the article exists
// Desperado's skull.

/*STATE LIST (outdated lmao)

- 0: Inactive
- 1: Idle
- 2: Hitstun
- 3: Bashed
- 4: Dying
- 5: Respawning

- Attack: AT_FSPECIAL
	- Window 1: Startup
	- Window 2: Active
	- Window 3: Endlag
	
- Attack: AT_USTRONG
	- Unfilled

*/

ignores_walls = false;
player_id.head_lockout = false;
follow_player = false;

//#region Hittability handling
is_hittable = !(state = 0 || (state == 3 && window == 1) || state == 4 || state == 5);
can_be_hit[player] = 3;

with oPlayer {
	if (!clone && state != PS_ATTACK_AIR && state != PS_ATTACK_GROUND) {
		other.last_attack[player] = noone;
	}
}
//#endregion

//#region Death / blast zone / clairen field handling

if (state != 4 && state != 5) {
	
	if (health <= 0 && state != 2) {
		state = 4;
		state_timer = 0;
	}
	
	else if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
		state = 4;
		state_timer = 0;
		visible = false;
		y = get_stage_data(SD_BOTTOM_BLASTZONE_Y) - 1;
		// might be cute to have a mini-death-explosion-slash-poof-of-smoke-vfx? also might be too much work lmao
		// todo: sfx
	}
	
	else if (x < get_stage_data(SD_LEFT_BLASTZONE_X)) {
		state = 4;
		state_timer = 0;
		visible = false;
		x = get_stage_data(SD_LEFT_BLASTZONE_X) + 1;
		// todo: sfx
	}
	
	else if (x > get_stage_data(SD_RIGHT_BLASTZONE_X)) {
		state = 4;
		state_timer = 0;
		visible = false;
		x = get_stage_data(SD_RIGHT_BLASTZONE_X) - 1;
		// todo: sfx
	}
	
	if (place_meeting(x, y, asset_get("plasma_field_obj")) && state != 0) {
		state = 4;
		state_timer = 0;
		sound_play(asset_get("sfx_clairen_hit_med"));
	}
	
}

//#endregion

//#region Bash handling

unbashable = !(state = 0 || state == 4 || state == 5);
if (getting_bashed && !unbashable) {
	state = 3;
	state_timer = 0;
	window = 1;
	window_timer = 1;
	orig_player = player;
	orig_player_id = player_id;
}

//#endregion

print_debug(state);

switch (state) {
	
	//#region State 0: Inactive	------------------------------------------------
	case 0:
		health = max_health;
		sprite_index = sprite_get("null");
	    vsp = 0;
	    hsp = 0;
	    window = 1;
	    break;
	//#endregion
	
	//#region State 1: Idle	----------------------------------------------------
	case 1:
		visible = true;
	    sprite_index = sprite_get("skullidle");
	    image_index = state_timer * player_id.idle_anim_speed;
	    hsp *= 0.9;
		vsp *= 0.9;
	    
	    has_hit = false;
	    
	    if (!free) y--;
	    
	    /*
	    // USpecial reattach
	    if (in_reattach_range() && player_in_attack(AT_USPECIAL) && player_id.window = 2) {
	    	state = 0;
			state_timer = 0;
			sprite_index = sprite_get("null");
	    }*/
	    
	    /* Movement with left stick. This felt awful
	    var is_mobile = player_id.state_cat == SC_GROUND_NEUTRAL
	    	|| player_id.state_cat == SC_AIR_NEUTRAL
	    	|| player_id.state == PS_DASH_START
	    	|| player_id.state == PS_DASH
	    	|| player_id.state == PS_DASH_STOP
	    	|| player_id.state == PS_DASH_TURN;
	    
	    if (state_timer == 1) hsp = 0;
		if (is_mobile && player_id.left_down) {
			if (hsp == -3) hsp = -4;
			else if (hsp > -3) hsp -= 2;
		} else if (is_mobile && player_id.right_down) {
			if (hsp == 3) hsp = 4;
			if (hsp < 4) hsp += 2;
		} else if (hsp > 0) hsp--;
		else if (hsp < 0) hsp++;
		*/
		
	    window = 1;
	    //read_inputs();
	    
	    break;
	//#endregion
	
	//#region State 2: Hitstun -------------------------------------------------
	case 2:
		sprite_index = sprite_get("skullhurt");
		image_index = state_timer / 4;
		if (hitstop <= 0) {
			vsp += 0.4;
			if (state_timer > 20) {
				state = 1;
				state_timer = 0;
			}
		}
		
		// The wall detection of all time
		if (hsp == 0 && !moving_vertically) {
			state = 1;
			state_timer = 0;
			sprite_index = sprite_get("skullidle");
			image_index = 0;
			spr_dir *= -1;
			hsp = old_hsp * -1;
		}
		
		// Ground bounce detection (backup)
		if (!free) {
			state = 1;
			state_timer = 0;
			sprite_index = sprite_get("skullidle");
			image_index = 0;
			vsp = old_vsp * -1;
			hsp = old_hsp;
		}
		
		old_hsp = hsp;
		old_vsp = vsp;
		
		break;
	//#endregion
		
	//#region State 3: Bashed ------------------------------------------------
	case 3:
		visible = true;
	    
	    player_id.head_lockout = true;
		
		switch (window) {
			
			case 1:
			
			    if (window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
			    	sprite_index = sprite_get("skullhurt");
			    	image_index = 0;
			    	spr_dir = bashed_id.spr_dir;
			    }
			    
			    player = orig_player;
				player_id = orig_player_id;
			    
				if (!getting_bashed) {
					window = 2;
					window_timer = 0;
					player = orig_player;
					player_id = orig_player_id;
				}
				
				break;
				
			case 2:
				sprite_index = sprite_get("skullactive");
				mask_index = sprite_get("skullhurtbox");
				image_index = 1 + (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.2, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hsp *= 2/3
					vsp *= 2/3
					moving_vertically = (hsp == 0);
					
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
					hitbox.projectile_parry_stun = false; // just handling this manually......
				}
				
				// End if it takes too long
				if ( window_timer >= 45 ) {
					hitbox = null;
					window = 3;
					window_timer = 0;
					if (vsp > 4) vsp = 4;
					break;
				}
				
				// Update hitbox
				if (hitbox != null) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
					hitbox.player = bashed_id.player;
				}
				
				// Bounce detections
				if (hitstop <= 0) {
					
					// The wall detection of all time
					if (hsp == 0 && !moving_vertically) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						spr_dir *= -1;
						hsp = 5*spr_dir;
					}
					
					// Enemy bounce detection
					if (has_hit) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						vsp = -3;
						hsp = moving_vertically ? 0 : -4*spr_dir;
						has_hit = false;
					}
					
					// Ground bounce detection (backup)
					if (!free) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						vsp = -4;
						hsp = moving_vertically ? 0 : 3*spr_dir;
					}
					
				}
				
				break;
			
			// Slow down
			case 3:
				
				hitbox = null;
				
				image_index = 5;
				hsp *= 0.9;
				vsp *= 0.9;
				
				if (window_timer >= 5) {
					state = 1;
					state_timer = 0;
				}
				break;
			
		}
		
		break;
	//#endregion
	
	//#region State 4: Dying ---------------------------------------------------
	case 4:
		hsp = 0;
		vsp = 0;
	
		// Visibility inherited by whatever passed it here
		sprite_index = sprite_get("skulldie");
		player_id.head_lockout = true;
		
		image_index = state_timer / 5;
		if (image_index >= 6) {
			state = 5;
			state_timer = 0;
			visible = false;
		}
		
		// TODO: add sfx
		
		break;
	//#endregion
	
	//#region State 5: Respawning ----------------------------------------------
	case 5:
		
		health = max_health;
		
		// not dealing with this quite yet~
		state = 0;
		state_timer = 0;
		
		// TODO: add sfx
		
		break;
	//#endregion
	
		
	//#region Attacks ----------------------------------------------------------
	
	//#region Attack: AT_FSPECIAL ----------------------------------------------
	case AT_FSPECIAL:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    player_id.head_lockout = true;
		
		switch (window) {
			
			case 1:
				image_index = 0;
				hsp *= 0.8
				vsp *= 0.8
				if (window_timer == 12) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					sound_play(asset_get("sfx_spin"));
				} else if (window_timer >= 13) {
					window = 2;
					window_timer = 0;
				}
				break;
				
			case 2:
				image_index = 1 + (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.2, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hsp = 5.5*spr_dir;
					vsp = -3;
					
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
				}
				
				// TODO: if this stays, change to a separate FSpecial lockout
				player_id.head_lockout = (window_timer < 30);
				
				// End just before hitting ground (or if it takes too long)
				var offset = (vsp > 4 ? 40 : 6.66*vsp + 10);
				if ( window_timer >= 45 || ( vsp > 0 && (position_meeting(x, y+offset, asset_get("par_block")) || position_meeting(x, y+30, asset_get("par_jumpthrough"))) ) ) {
					hitbox = null;
					window = 3;
					window_timer = 0;
					if (vsp > 4) vsp = 4;
					break;
				}
				
				// Update hitbox
				if (hitbox != null) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
				}
				
				// Bounce detections
				if (hitstop <= 0) {
					
					// The wall detection of all time
					if (hsp == 0) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						spr_dir *= -1;
						hsp = 1.5*spr_dir;
					}
					
					// Enemy bounce detection
					if (has_hit) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						vsp = -3;
						hsp = -4*spr_dir;
						has_hit = false;
					}
					
					// Ground bounce detection (backup)
					if (!free) {
						state = 1;
						state_timer = 0;
						sprite_index = sprite_get("skullidle");
						image_index = 0;
						vsp = -4;
						hsp = 3*spr_dir;
					}
					
				}
				
				break;
			
			// Slow down
			case 3:
				
				hitbox = null;
				
				image_index = 5;
				hsp *= 0.9;
				vsp *= 0.9;
				
				if (window_timer >= 5) {
					state = 1;
					state_timer = 0;
				}
				break;
			
		}
		
	    break;
	//#endregion
	
	//#region Attack: AT_USTRONG -----------------------------------------------
	case AT_USTRONG:
		visible = true;
		ignores_walls = true;
	    sprite_index = sprite_get("head_ustrong");
	    player_id.head_lockout = true;
	    
	    if (hsp > 0) hsp--;
		else if (hsp < 0) hsp++;
		
		switch (window) {
			
			case 1:
				image_index = 0;
				if (window_timer == 13) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					sound_play(asset_get("sfx_swipe_heavy2"));
				} else if (window_timer >= 15) {
					window = 2;
					window_timer = 0;
				}
				break;
				
			
			case 2:
				image_index = 1;
				
				if (window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hitbox = create_hitbox(AT_USTRONG, 2, x+(10*spr_dir), y-62);
					hitbox.spr_dir = spr_dir;
				}
				
				if (window_timer >= 4 - 1) {
					window = 3;
					window_timer = 0;
				}
				break;
				
			case 3:
				image_index = 2 + (window_timer*2/20);
				
				if (window_timer > 19) {
					state = 1;
					state_timer = 0;
					sprite_index = sprite_get("head_idle");
	    			image_index = state_timer * player_id.idle_anim_speed;
	    			y -= 72;
				}
				
				break;
			
		}
		
	    break;
	//#endregion
	
}
//#endregion


//#region Make time progress + run hit detection
if (hitstop <= 0) {
	state_timer++;
	window_timer++;
	hitstop = 0;
}
else hitstop = floor(hitstop);
//#endregion

#define read_inputs() // Old function. Consider removing.
	if (player_id.state_cat != SC_GROUND_COMMITTED && player_id.state_cat != SC_AIR_COMMITTED) return;
	if ((player_id.state == PS_ATTACK_GROUND || player_id.state == PS_ATTACK_AIR) && player_id.attack == AT_NSPECIAL) return;
	if (player_id.state == PS_PRATFALL || player_id.state == PS_PRATLAND) return;
	with player_id {
		if (special_pressed && joy_pad_idle && state != 3) {
			other.state = AT_NSPECIAL;
			other.state_timer = 0;
			other.window = 1;
			other.window_timer = 1;
			other.hsp = 0;
			other.vsp = 0;
			other.follow_player = false;
			if (left_down) other.spr_dir = -1;
			if (right_down) other.spr_dir = 1;
		}
		else if (up_strong_pressed) {
			other.state = AT_USTRONG;
			other.state_timer = 0;
			other.window = 1;
			other.window_timer = 1;
			other.hsp = 0;
			other.vsp = 0;
			other.follow_player = false;
			if (left_down) other.spr_dir = -1;
			if (right_down) other.spr_dir = 1;
		}
	}
	return;
	
#define set_head_state(new_state)
	state = new_state;
	state_timer = 0;
	window = 1;
	window_timer = 1;
	return;

#define player_in_attack(_index)
	return (player_id.state == PS_ATTACK_GROUND || player_id.state == PS_ATTACK_AIR) && player_id.attack == _index;

#define in_reattach_range()
	var _xdist = abs(x-player_id.x);
	var _ydist = abs(y-(player_id.y-24));
	return _xdist <= 12 && _ydist <= 28


// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion