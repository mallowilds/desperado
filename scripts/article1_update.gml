// CAUTION: This is an unedited placeholder. Some things will not work as expected.

// article1_update - runs every frame the article exists
// Desperado's skull.

/*STATE LIST (outdated lmao)

- 0: Inactive

- 1: Idle

- Attack: AT_FSPECIAL
	- Window 1: Startup
	- Window 2: Active
	- Window 3: Endlag

*/

ignores_walls = false;
player_id.head_lockout = false;
follow_player = false;

switch (state) {
	
	//#region State 0: Inactive	------------------------------------------------
	case 0:
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
	    vsp = 0;
	    hsp = 0;
	    
	    // USpecial reattach
	    if (in_reattach_range() && player_in_attack(AT_USPECIAL) && player_id.window = 2) {
	    	state = 0;
			state_timer = 0;
			sprite_index = sprite_get("null");
	    }
	    
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
	    read_inputs();
	    
	    break;
	//#endregion
	
	//#region State 2: Pushed down ---------------------------------------------
	case 2:
		visible = true;
	    sprite_index = sprite_get("head_idle");
	    image_index = state_timer * player_id.idle_anim_speed;
	    
		if (state_timer == 1) vsp = 5;
		else vsp -= 0.5;
		if (vsp <= 0) {
			state = 1;
			state_timer = 0;
			vsp = 0;
		}
	
		window = 1;
		read_inputs();
		
		break;
	//#endregion
		
	//#region State 3: Movement ------------------------------------------------
	case 3:
		
		//#region Anims
		visible = true;
		
		if (player_in_attack(AT_NSPECIAL)) {
			
			if (player_id.joy_pad_idle && !hiding) {
				sprite_index = sprite_get("head_idle");
				image_index = state_timer * player_id.idle_anim_speed;
				
			} else if (!player_id.joy_pad_idle) {
				
				hiding = false;
				sprite_index = sprite_get("head_nspecial_move");
				image_index = 2;
				
				if (player_id.left_down) spr_dir = -1;
				else if (player_id.right_down) spr_dir = 1;
				
				var _forward_down = player_id.left_down || player_id.right_down;
				if (player_id.up_down) image_index = 4 - _forward_down;
				if (player_id.down_down) image_index = 0 + _forward_down;
				
			} else {
				sprite_index = sprite_get("null");
				y = player_id.y - 42;
			}
			
		} else {
			
			if (player_id.state == PS_IDLE) {
				sprite_index = sprite_get("head_idle");
				image_index = state_timer * player_id.idle_anim_speed;
				
			} else {
				sprite_index = sprite_get("head_nspecial_move");
				image_index = 2;
				spr_dir = player_id.spr_dir;
				if (abs(player_id.vsp) > 3) {
					if (player_id.vsp > 0) image_index = 1;
					else image_index = 3;
				}
			}
			
		}
		//#endregion
		
		//#region Reattachment logic
		var _in_range = in_reattach_range();
		if (!player_id.special_down) reattach = true;
		else if (state_timer = 0) reattach = !_in_range;
		
		if (_in_range && reattach && player_in_attack(AT_NSPECIAL)) {
			state = 0;
			sprite_index = sprite_get("null");
			vsp = 0;
	    	hsp = 0;
			exit;
		} else if (!reattach) {
			reattach = !_in_range;
		}
		//#endregion
		
		
		//#region Movement
		if (player_in_attack(AT_NSPECIAL)) {
			var _spd;
			var _ang;
			
			if (!player_id.joy_pad_idle) {
				hsp += lengthdir_x(1, player_id.joy_dir);
				vsp += lengthdir_y(1, player_id.joy_dir);
				
				_spd = point_distance(0, 0, hsp, vsp);
				_ang = point_direction(0, 0, hsp, vsp);
				_spd = clamp(_spd, 0, 5);
				
				hsp = lengthdir_x(_spd, _ang);
				vsp = lengthdir_y(_spd, _ang);
			}
			
			else {
				_spd = point_distance(0, 0, hsp, vsp);
				_ang = point_direction(0, 0, hsp, vsp);
				_spd = clamp(_spd-2, 0, 5);
				
				hsp = lengthdir_x(_spd, _ang);
				vsp = lengthdir_y(_spd, _ang);
			}
		} else {
			follow_player = true;
		}
		//#endregion
		
		
		if (!player_id.special_down) {
			state = AT_NSPECIAL;
			state_timer = 0;
			window_timer = 0;
			follow_player = false;
		}
		
		window = 1;
		read_inputs();
		
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
				image_index = (window_timer / 9);
				if (window_timer == 16) {
					sound_play(asset_get("sfx_spin"));
				} else if (window_timer >= 18) {
					window = 2;
					window_timer = 0;
				}
				break;
			
			case 2:
				image_index = 2+((window_timer / 2)%2);
				hsp = 10*spr_dir;
				
				if (window_timer == 1) {
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
				}
				if (instance_exists(hitbox)) {
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
				}
				
				if (window_timer >= 14) {
					window = 3;
					window_timer = 0;
				}
				break;
				
			case 3:
				image_index = 5;
				hsp *= 0.8;
				if (window_timer >= 10) {
					state = 1;
					state_timer = 0;
				}
				break;
			
		}
		
	    break;
	//#endregion
	
	//#region Attack: AT_DSPECIAL ----------------------------------------------
	case AT_DSPECIAL:
	
		visible = true;
	    sprite_index = sprite_get("head_rotations");
	    image_index = 0;
	    player_id.head_lockout = true;
		
		switch (window) {
			
			case 1:
				vsp = -12;
				x = player_id.x;
				hsp = player_id.hsp;
				
				if (window_timer == 1) {
					sound_play(asset_get("sfx_spin"));
				}
				
				if (window_timer == 1) {
					hitbox = create_hitbox(AT_DSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
				}
				if (instance_exists(hitbox)) {
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
				}
				
				if (window_timer >= 6) {
					window = 2;
					window_timer = 0;
				}
				break;
				
			case 2:
				vsp *= 0.8;
				hsp *= 0.8;
				if (window_timer > 10) {
					state = 1;
					state_timer = 0;
				}
				break;
			
		}
		
	    break;
	//#endregion
	
	//#region Attack: AT_DSPECIAL_2 ----------------------------------------------
	case AT_DSPECIAL_2:
	
		visible = true;
		ignores_walls = true;
	    sprite_index = sprite_get("head_fspecial");
	    player_id.head_lockout = true;
		
		switch (window) {
			
			case 1:
				image_index = (window_timer / 15);
				if (window_timer == 30) {
					sound_play(asset_get("sfx_spin"));
				} else if (window_timer >= 32) {
					window = 2;
					window_timer = 0;
				}
				break;
			
			case 2:
				image_index = 2+((window_timer / 2)%2);
				
				if (point_distance(x, y, player_id.x, player_id.y-36) < 15) move_speed = point_distance(x, y, player_id.x, player_id.y-50);
				else move_speed = 15;
				move_angle = point_direction(x, y, player_id.x, player_id.y-36);
				
				hsp = lengthdir_x(move_speed, move_angle);
				vsp = lengthdir_y(move_speed, move_angle);
				
				if (window_timer == 1) {
					hitbox = create_hitbox(AT_DSPECIAL_2, 1, x, y);
					hitbox.spr_dir = spr_dir;
				}
				
				if (instance_exists(hitbox)) {
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
				}
				
				if (point_distance(x, y, player_id.x, player_id.y-36) < 10) {
					state = 0;
					state_timer = 0;
					if (instance_exists(hitbox)) hitbox.destroyed = true;
					player_id.window++;
				}
				break;
			
		}
		
	    break;
	//#endregion
	
	//#region Attack: AT_NSPECIAL release --------------------------------------
	case AT_NSPECIAL:
		
		visible = true;
	    sprite_index = sprite_get("head_nspecial_release");
	    player_id.head_lockout = true;
	    
	    _spd = point_distance(0, 0, hsp, vsp);
		_ang = point_direction(0, 0, hsp, vsp);
		_spd = clamp(_spd-2, 0, 5);
			
		hsp = lengthdir_x(_spd, _ang);
		vsp = lengthdir_y(_spd, _ang);
		
		switch (window) {
			
			case 1:
				image_index = window_timer*4/8;
				if (window_timer > 8) {
					window = 2;
					window_timer = 0;
					sound_play(asset_get("sfx_ori_charged_flame_release"));
				}
				break;
			
			case 2:
				image_index = 4+(window_timer*5/15);
				
				if (window_timer == 3) {
					hitbox = create_hitbox(AT_NSPECIAL, 1, x, y-20);
					hitbox.spr_dir = spr_dir;
				} else if (window_timer >= 14) {
					window = 3;
					window_timer = 0;
				}
				
				break;
				
			case 3:
				image_index = 9 + (window_timer*2/10);
				
				if (window_timer >= 10) {
					state = 1;
					state_timer = 0;
					sprite_index = sprite_get("head_idle");
	    			image_index = state_timer * player_id.idle_anim_speed;
				}
				
				break;
			
		}
		
	    break;
		
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
				if (window_timer == 13) {
					sound_play(asset_get("sfx_swipe_heavy2"));
				} else if (window_timer >= 15) {
					window = 2;
					window_timer = 0;
				}
				break;
			
			case 2:
				image_index = 1;
				
				if (window_timer == 1) {
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

//#region Magic Circle Display
if (mc_active != (state == 3)) {
	
	mc_active = (state == 3)
	
	if (mc_active) {
		mc_xscale = 0.15;
		mc_yscale = 0.15;
		mc_alpha = 0;
	} else {
		mc_xscale = 1;
		mc_yscale = 1;
		mc_dissipation = mc_alpha / 20
	}
	
}


if (mc_active) {
	if (mc_xscale < 1) {
			mc_xscale += 0.05;
			mc_yscale += 0.05;
	}
	if (player_in_attack(AT_NSPECIAL) && window != 3) { // DSpecial active, moving autonomously
		mc_alpha = clamp(mc_alpha+0.075, 0, 1);
	} else { // DSpecial stored, following player
		if (mc_alpha > 0.5) mc_alpha -= 0.075;
		mc_alpha = clamp(mc_alpha, 0.5, 1);
	}
}

else if (!mc_active && mc_alpha > 0) {
	mc_xscale += 0.05;
	mc_yscale -= 0.1;
	mc_alpha = clamp(mc_alpha-mc_dissipation, 0, 1);
}

//#endregion

//#region Make time progress
state_timer++;
window_timer++;
//#endregion

#define read_inputs()
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