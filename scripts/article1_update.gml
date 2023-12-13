
// article1_update - runs every frame the article exists
// Desperado's skull.

/*STATE LIST

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

//#region Hittability handling --------------------------------------------------------
is_hittable = !(state = 0 || state == 3 || state == 4 || state == 5); // WILL BE DEPRECATED SOON - use below hittable var for checks
can_be_hit[player] = 3;
hittable = !(state = 0 || state == 3 || state == 4 || state == 5);

if (state != AT_NSPECIAL) shots_absorbed = 0;

with player_id.object_index {
	if (!clone && state != PS_ATTACK_AIR && state != PS_ATTACK_GROUND) {
		other.last_attack[player] = noone;
	}
}
//#endregion


//#region NSpecial blast drawing --------------------------------------------------------

if (shot_visual != noone) {
	if (hitstop <= 0 || state != AT_NSPECIAL) shot_visual.sp_lifetime++;
    if (shot_visual.sp_lifetime >= shot_visual.sp_shot_lifetime + shot_visual.sp_smoke_time_offset + shot_visual.sp_smoke_lifetime) {
        shot_visual = noone;
    }
}

//#endregion


//#region Death / blast zone / clairen field handling ------------------------------------

if (state != 4 && state != 5) {
	
	if (health <= 0 && state != 2) {
		state = 4;
		state_timer = 0;
		respawn_penalty = true;
	}
	
	else if (place_meeting(x, y, asset_get("plasma_field_obj")) && state != 0) {
		state = 4;
		state_timer = 0;
		respawn_penalty = true;
		sound_play(asset_get("sfx_clairen_hit_med"));
	}
	
	else if (player_id.object_index == oPlayer) {
		
		if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
			state = 4;
			state_timer = 0;
			visible = false;
			y = get_stage_data(SD_BOTTOM_BLASTZONE_Y) - 1;
			respawn_penalty = true;
			// might be cute to have a mini-death-explosion-slash-poof-of-smoke-vfx? also might be too much work lmao
			// todo: sfx
		}
		
		else if (x < get_stage_data(SD_LEFT_BLASTZONE_X)) {
			state = 4;
			state_timer = 0;
			visible = false;
			x = get_stage_data(SD_LEFT_BLASTZONE_X) + 1;
			respawn_penalty = true;
			// todo: sfx
		}
		
		else if (x > get_stage_data(SD_RIGHT_BLASTZONE_X)) {
			state = 4;
			state_timer = 0;
			visible = false;
			x = get_stage_data(SD_RIGHT_BLASTZONE_X) - 1;
			respawn_penalty = true;
			// todo: sfx
		}
		
	}
	
	
}

//#endregion


//#region Bash handling --------------------------------------------------------

unbashable = (state = 0 || state == 4 || state == 5);
if (getting_bashed && !unbashable) {
	state = 3;
	state_timer = 0;
	window = 1;
	window_timer = 1;
	has_hit = false;
}

//#endregion


switch (state) {
	
	//#region State 0: Inactive	------------------------------------------------
	case 0:
		health = max_health;
		sprite_index = sprite_get("null");
	    vsp = 0;
	    hsp = 0;
	    window = 1;
	    can_fspecial = false;
		can_sync_attack = false;
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
	    can_fspecial = true;
		can_sync_attack = true;
	    
	    if (!free) y--;
		
	    window = 1;
	    
	    break;
	//#endregion
	
	//#region State 2: Hitstun -------------------------------------------------
	case 2:
		sprite_index = sprite_get("skullhurt");
		image_index = state_timer / 4;
		can_fspecial = false;
		can_sync_attack = false;
		
		
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
	    
	    can_fspecial = false;
		can_sync_attack = false;
		
		player = orig_player;
		player_id = orig_player_id;

		switch (window) {
			
			case 1:
			
			    if (window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
			    	sprite_index = sprite_get("skullhurt");
			    	image_index = 0;
			    	spr_dir = bashed_id.spr_dir;
			    }
			    
				if (!getting_bashed) {
					window = 2;
					window_timer = 0;
				}
				
				break;
				
			case 2:
				
				sprite_index = sprite_get("skullactive");
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
					hitbox = noone;
					window = 3;
					window_timer = 0;
					if (vsp > 4) vsp = 4;
					break;
				}
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hitstop <= 0 ? hsp : 0;
					hitbox.vsp = hitstop <= 0 ? vsp : 0;
					hitbox.player = bashed_id.player;
				}
				
				// Bounce detections
				if (hitstop <= 0) {
					
					// The wall detection of all time
					if (hsp == 0 && !moving_vertically) {
						hitbox = noone;
						window = 3;
						window_timer = 0;
						spr_dir *= -1;
						hsp = 5*spr_dir;
					}
					
					// Enemy bounce detection
					if (has_hit) {
						hitbox = noone;
						window = 3;
						window_timer = 0;
						vsp = -3;
						hsp = moving_vertically ? 0 : -4*spr_dir;
						has_hit = false;
					}
					
					// Ground bounce detection (backup)
					if (!free) {
						hitbox = noone;
						window = 3;
						window_timer = 0;
						vsp = -4;
						hsp = moving_vertically ? 0 : 3*spr_dir;
					}
					
				}
				
				break;
			
			// Slow down
			case 3:
				
				hitbox = noone;
				
				image_index = window_timer > 11 ? 5 : 1 + (window_timer/3)%4;
				hsp *= 0.9;
				vsp *= 0.9;
				
				if (window_timer >= 15) {
					state = 4;
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
		can_fspecial = false;
		can_sync_attack = false;
		
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
		
		can_fspecial = false;
		can_sync_attack = false;
		
		// not dealing with this quite yet~
		if (state_timer > respawn_delay + (respawn_penalty ? penalty_delay : 0)) {
			state = 0;
			state_timer = 0;
		}
		
		// TODO: add sfx
		
		break;
	//#endregion
	
		
	//#region Attacks ---------------------------------------------------------
	
	//#region Command Attack: AT_FSPECIAL ------------------------------------
	case AT_FSPECIAL:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    can_fspecial = true;
		can_sync_attack = false;
		
		switch (window) {
			
			case 1:
				// Deprecated
				break;
				
			case 2:
				image_index = (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.2, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hsp = (6+throw_dir) *spr_dir;
					vsp = -3.5 + 3*throw_dir;
					
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
				}
				
				// End just before hitting ground (or if it takes too long)
				var offset = (vsp > 4 ? 40 : 6.66*vsp + 10);
				if ( window_timer >= 25 || ( vsp > 0 && (position_meeting(x, y+offset, asset_get("par_block")) || position_meeting(x, y+30, asset_get("par_jumpthrough"))) ) ) {
					hitbox = noone;
					window = 3;
					window_timer = 0;
					if (vsp > 4) vsp = 4;
					break;
				}
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
					
					spawn_ash_particle(player*3, player*3+1);
				}
				
				// Bounce detections
				if (hitstop <= 0) {
					
					// The wall detection of all time
					if (hsp == 0) {
						window = 3;
						window_timer = 0;
						spr_dir *= -1;
						hsp = 1.5*spr_dir;
					}
					
					/*
					// Enemy bounce detection
					if (has_hit) {
						window = 3;
						window_timer = 0;
						vsp = -3;
						hsp = -4*spr_dir;
						has_hit = false;
					}*/
					
					// Ground bounce detection (backup)
					if (!free) {
						window = 3;
						window_timer = 0;
						vsp = -4;
						hsp = 3*spr_dir;
					}
					
				}
				
				break;
			
			// Slow down
			case 3:
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
					
					spawn_ash_particle(player*3, player*3+1);
				}
				
				image_index = (4*(hitbox==noone)) + (window_timer/3)%4;
				hsp *= 0.91;
				vsp *= 0.91;
				
				if (window_timer >= 36) {
					window = 4;
					window_timer = 0;
					hitbox = noone;
				}
				break;
			
			
			// Return
			case 4:
			
				image_index = 4 + (window_timer/3)%4;
				
				var target_sp = 2.25*ln(0.9*window_timer+1); // https://www.desmos.com/calculator/d2byh0mgnk
				
				if (window_timer == 1) angle_change = clamp((player_id.x-x)/10, -50, 50); // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
				else if (angle_change > 0) angle_change = clamp(angle_change-0.5, 0, angle_change);
				else if (angle_change < 0) angle_change = clamp(angle_change+0.5, angle_change, 0);
				
				if (point_distance(x, y, player_id.x, player_id.y-26) < target_sp) move_speed = point_distance(x, y, player_id.x, player_id.y-50);
				else move_speed = target_sp;
				move_angle = point_direction(x, y, player_id.x, player_id.y-26);
				
				hsp = lengthdir_x(move_speed, move_angle+angle_change);
				vsp = lengthdir_y(move_speed, move_angle+angle_change);
				
				if (point_distance(x, y, player_id.x, player_id.y-26) < 10) {
					state = 0;
					state_timer = 0;
					can_fspecial = false;
					if (player_id.state != PS_HITSTUN && player_id.state != PS_HITSTUN_LAND) create_hitbox(AT_FSPECIAL_2, 1, player_id.x+(player_id.spr_dir*-6), player_id.y-52);
				}
				
				// 3 seconds in: just kill off the skull, it's probably trapped
				if (state_timer > 180) {
					state = 4;
					state_timer = 0;
					respawn_penalty = true;
					sprite_index = sprite_get("skullidle");
					image_index = 0;
					vsp = -4;
					hsp = 3*spr_dir;
					can_fspecial = false;
				}
				
		}
		
		break;
	//#endregion
	
	//#region Command Attack: AT_FSPECIAL_2 ---------------------------------------------
	case AT_FSPECIAL_2:
		
		//visible = true;
	    can_fspecial = false;
		can_sync_attack = false;
		
		hsp *= 0.9;
		vsp *= 0.9;
		
		switch window {
			
			case 1:
				visible = true;
				sprite_index = sprite_get("skullactive");
				image_index = 4;
				
				spawn_ash_particle(player*3, player*3+1);
				
				if (window_timer > 6) {
					state = 2;
					state_timer = 0;
				}
			
			case 2:
				visible = false;
				spawn_ash_particle(player*3, player*3+1);
				state = 4;
				state_timer = 0;
				respawn_penalty = false;
				create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				break;
		}
		
		break;
		
	//#endregion
	
	//#region Command Attack: AT_FTHROW ------------------------------------------------
	case AT_FTHROW:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    can_fspecial = false;
		can_sync_attack = false;
		
		switch (window) {
				
			case 1:
				image_index = (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.2, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hsp = 6*spr_dir;
					vsp = -3.5;
					
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
					
					has_hit = false;
				}
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
				}
				
				spawn_ash_particle(player*3, player*3+1);
				
				// Explode detection
				if (hitstop <= 0 && (window_timer > 32 || hsp == 0 || !free || has_hit)) {
					window = 2;
					window_timer = 0;
				}
				
				break;
				
			case 2:
				sprite_index = sprite_get("skullactive");
				image_index = 4 + (window_timer/3)%4;
				
				spawn_ash_particle(player*3, player*3+1);
				
				if (window_timer > 6) {
					window = 3;
					window_timer = 0;
				}
			
			case 3:
				visible = false;
				state = 4;
				state_timer = 0;
				respawn_penalty = false;
				create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				break;
			
		}
		
		break;	
	
	//#endregion
	
	//#region Command Attack: AT_UTHROW ------------------------------------------------
	case AT_UTHROW:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    can_fspecial = false;
		can_sync_attack = false;
		
		switch (window) {
				
			case 1:
				image_index = (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.4, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hsp = 3*spr_dir;
					vsp = -9;
					
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
					
					has_hit = false;
				}
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
				}
				
				spawn_ash_particle(player*3, player*3+1);
				
				// Explode detection
				if (hitstop <= 0 && (window_timer > 40 || hsp == 0 || !free || has_hit)) {
					window = 2;
					window_timer = 0;
				}
				
				break;
				
			case 2:
				sprite_index = sprite_get("skullactive");
				image_index = 4 + (window_timer/3)%4;
				
				spawn_ash_particle(player*3, player*3+1);
				
				if (window_timer > 6) {
					window = 3;
					window_timer = 0;
				}
			
			case 3:
				visible = false;
				state = 4;
				state_timer = 0;
				respawn_penalty = false;
				create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				break;
			
		}
		
		break;	
	
	//#endregion
	
	//#region Reactive Attack: AT_NSPECIAL ---------------------------------------------
	case AT_NSPECIAL:
		
		switch window {
			
			case 1:
				
				sprite_index = sprite_get("skullhurt");
				
				draw_x = 0;
				draw_y = 0;
				
				can_fspecial = false;
				can_sync_attack = false;
				has_hit = false;
				
				hsp = 0;
				vsp = 0;
				
				charge_time = 75 - 5*shots_absorbed
				
				if (window_timer >= 10) {
					target_id = get_max_damage_player(false);
					window = 2;
					window_timer = 0;
					sprite_index = sprite_get("null");
					sound_play(sound_get("desp_skullcharge"), 0, noone, 1, .8)
					
					reticle_angle = (target_id != noone ? point_direction(x, y, target_id.x, target_id.y-target_id.char_height/2) : 90-60*spr_dir);
					reticle_offset_angle = 50;
					reticle_alpha = 0;
					reticle_flash = 0;
					reticle_flash_peaked = false;
				}
				break;
			
			case 2:
				if (target_id != noone && target_id.state == PS_RESPAWN) target_id = noone;
				
				draw_x = clamp(draw_x-2+random_func(2*player, 4, false), -6+(window_timer*6/charge_time), 6-(window_timer*6/charge_time));
				draw_y = clamp(draw_y-2+random_func(2*player+1, 4, false), -6+(window_timer*6/charge_time), 6-(window_timer*6/charge_time));
				
				if (target_id != noone) reticle_angle = point_direction(x, y, target_id.x, target_id.y-target_id.char_height/2);
				if (reticle_angle > 90 && reticle_angle < 270) spr_dir = -1;
				else if (reticle_angle != 90 && reticle_angle != 270) spr_dir = 1;
				reticle_offset_angle -= (50/charge_time); // denominator is window duration in frames
				if (reticle_alpha < 0.8) reticle_alpha = window_timer/90; // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
				if (reticle_offset_angle <= 0) {
					reticle_offset_angle = 0;
					window = 3;
					window_timer = 0;
				}
				
				break;
			
			case 3:
			
				hittable = false; // TODO: remove after transition to Supersonic hit template
				is_hittable = false;
				
				draw_x = 0;
				draw_y = 0;
				
				if (!reticle_flash_peaked) {
					reticle_flash = clamp(reticle_flash+0.3, 0, 1);
					if (reticle_flash == 1) reticle_flash_peaked = true;
				}
				else if (reticle_flash > 0) {
					reticle_flash -= 0.1;
					reticle_alpha = 0;
				}
				
				if (window_timer == 1 && hitstop <= 0) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					var vflash = spawn_hit_fx(x, y+24, player_id.vfx_flash)
	        		vflash.depth = depth - 1;
	        		vflash.spr_dir = spr_dir;
	        		sound_play(sound_get("desp_sharpen"));
				}
				if (window_timer >= 20) {
					window = 4;
					window_timer = 0;
					recoil_speed = -8
					
					with player_id {
						set_hitbox_value(AT_NSPECIAL, 3, HG_DAMAGE, 5 + (1 * other.shots_absorbed));
	    				set_hitbox_value(AT_NSPECIAL, 3, HG_BASE_KNOCKBACK, 8 + (0.2 * other.shots_absorbed));
	        			set_hitbox_value(AT_NSPECIAL, 3, HG_KNOCKBACK_SCALING, 0.8 + (0.05 * other.shots_absorbed));
					}
					
					create_reflected_shot(x+lengthdir_x(18, reticle_angle), y-30+lengthdir_y(18, reticle_angle), reticle_angle, AT_NSPECIAL, 3, 6, 24, -2)
					sound_play(sound_get("desp_shot"), 0, noone, 1, 1);
					sound_play(asset_get("sfx_mol_huge_explode"), 0, noone, 1, 1);
					
					shake_camera(round(2+shots_absorbed/2), round(3+shots_absorbed/2));
				}
				break;
			
			case 4:
				if (hitstop <= 0) {
					if (recoil_speed < 0) recoil_speed += 0.5;
					hsp = lengthdir_x(recoil_speed, reticle_angle);
					vsp = lengthdir_y(recoil_speed, reticle_angle);
				}
				
				if (window_timer >= 35) {
					state = 5;
					state_timer = 0;
				}
				
				break;
			
		}
		
		break;
	
	break;
	
	//#endregion
	
}
//#endregion


//#region Make time progress
if (hitstop <= 0) {
	state_timer++;
	window_timer++;
	hitstop = 0;
}
else hitstop = floor(hitstop);
//#endregion






#define set_head_state(new_state)
	state = new_state;
	state_timer = 0;
	window = 1;
	window_timer = 1;
	return;

#define player_in_attack(attack_index)
	return (player_id.state == PS_ATTACK_GROUND || player_id.state == PS_ATTACK_AIR) && player_id.attack == attack_index;

#define get_max_damage_player(include_self)
	var max_damage = -1;
	var max_player_id = noone;
	with player_id.object_index {
		if (get_player_damage(player) > max_damage && (include_self || player != other.player)) {
			max_damage = get_player_damage(player);
			max_player_id = self;
		}
	}
	return max_player_id;
	
#define create_reflected_shot(_x, _y, angle, attack_index, hbox_num, shot_lifetime, smoke_lifetime, smoke_time_offset) 
	
	var start_index = sprite_get("nspec_blast_close_ash");
	var tile_index = sprite_get("nspec_blast_segment_ash");
	var edge_index = sprite_get("nspec_blast_wall_ash");
	var edge_width = 38;
	var smoke_index = sprite_get("nspec_blast_smoke");
	
	var shot_length = 1600; // no collision yet
	
	shot_visual = {
        sp_x : _x,
        sp_y : _y,
        sp_angle : angle,
        sp_length : shot_length,
        sp_start_index : start_index,
        sp_tile_index : tile_index,
        sp_edge_index : edge_index,
        sp_edge_width : edge_width,
        sp_shot_lifetime : shot_lifetime,
        sp_smoke_index : smoke_index,
        sp_smoke_time_offset : smoke_time_offset,
        sp_smoke_lifetime : smoke_lifetime,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir,
    };
    
   	with player_id var hbox_rad = floor(get_hitbox_value(attack_index, hbox_num, HG_WIDTH)/2);
	var dist_so_far = hbox_rad;
	var cur_x = _x + lengthdir_x(hbox_rad, angle);
	var cur_y = _y + lengthdir_y(hbox_rad, angle);
	while(dist_so_far+hbox_rad < shot_length) {
		var hbox = create_hitbox(attack_index, hbox_num, round(cur_x), round(cur_y));
		hbox.head_obj = self;
		dist_so_far += 2*hbox_rad;
		cur_x = cur_x + lengthdir_x(2*hbox_rad, angle);
		cur_y = cur_y + lengthdir_y(2*hbox_rad, angle);
	}
	
	return;


#define spawn_ash_particle(seed1, seed2)
    var ash_type = "ashpart_" + string(1+random_func_2(seed1, 3, true));
    spawn_particle_random(ash_type, 18, seed2);


#define spawn_particle_random(in_sprite, lifetime, seed)
    var _x = x-20-hsp+random_func_2(seed, 40, false)
    var _y = y-60-vsp+random_func_2(seed+1, 40, false)
    var sparkle = {
        sp_x : _x,
        sp_y : _y,
        sp_sprite_index : sprite_get(in_sprite),
        sp_max_lifetime : lifetime,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir,
        sp_skull_owned : 1,
    };
    ds_list_add(player_id.sparkle_list, sparkle);


// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion