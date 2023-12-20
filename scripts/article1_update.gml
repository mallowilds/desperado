
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
hittable = !(state = 0 || state == 3 || state == 4 || state == 5);

if (state != AT_NSPECIAL) shots_absorbed = 0;

if (hittable) hit_detection();
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
	
	if (place_meeting(x, y, asset_get("plasma_field_obj")) && state != 0) {
		state = 4;
		state_timer = 0;
		respawn_penalty = true;
	}
	
	else if (player_id.object_index == oPlayer) {
		
		if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
			state = 4;
			state_timer = 0;
			sprite_index = sprite_get("null");
			y = get_stage_data(SD_BOTTOM_BLASTZONE_Y) - 1;
			respawn_penalty = true;
			// might be cute to have a mini-death-explosion-slash-poof-of-smoke-vfx? also might be too much work lmao
			// todo: sfx
		}
		
		else if (x < get_stage_data(SD_LEFT_BLASTZONE_X)) {
			state = 4;
			state_timer = 0;
			sprite_index = sprite_get("null");
			x = get_stage_data(SD_LEFT_BLASTZONE_X) + 1;
			respawn_penalty = true;
			// todo: sfx
		}
		
		else if (x > get_stage_data(SD_RIGHT_BLASTZONE_X)) {
			state = 4;
			state_timer = 0;
			sprite_index = sprite_get("null");
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
		sprite_index = sprite_get("null");
		visible = false;
	    vsp = 0;
	    hsp = 0;
	    window = 1;
	    can_fspecial = false;
	    ignores_walls = false;
	    
	    if (respawn_give_bullet) {
	    	if (player_id.num_bullets < 6) {
                player_id.num_bullets++;
                player_id.nametag_white_flash = 1;
                player_id.reload_anim_state = 3;
                player_id.reload_anim_timer = 0;
                sound_play(sound_get("desp_click"));
            }
            else {
                with (player_id) var discard_visual = instance_create(x, y-26, "obj_article3");
                discard_visual.state = 00;
                discard_visual.hsp = -3*(player_id.spr_dir);
                discard_visual.vsp = -4;
                player_id.reload_anim_state = 3;
                player_id.reload_anim_timer = 0;
                sound_play(asset_get("sfx_gus_land"));
            }
            respawn_give_bullet = false;
	    }
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
	    
	    if (!free) y--;
		
	    window = 1;
	    
	    break;
	//#endregion
	
	//#region State 2: Hitstun -------------------------------------------------
	case 2:
		sprite_index = sprite_get("skullhurt");
		image_index = state_timer / 4;
		can_fspecial = false;
		
		if (hitstop <= 0) {
			vsp += 0.4;
			if (state_timer > 20) {
				state = 4;
				state_timer = 0;
			}
		}
		
		// The wall detection of all time
		if (hsp == 0 && !moving_vertically) {
			state = 4;
			state_timer = 0;
			sprite_index = sprite_get("skulldie");
			image_index = 0;
			spr_dir *= -1;
			hsp = old_hsp * -1;
		}
		
		// Ground bounce detection (backup)
		if (!free) {
			state = 4;
			state_timer = 0;
			sprite_index = sprite_get("skulldie");
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
				
				has_hit = false;
				
				break;
				
			case 2:
				image_index = (window_timer/3)%4;
				
				if (hitstop <= 0) vsp = clamp(vsp+0.2, vsp, 7);
				
				if (hitstop <= 0 && window_timer == 1) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					hitbox = create_hitbox(AT_FSPECIAL, 1, x, y);
					hitbox.spr_dir = spr_dir;
					hitbox.head_obj = self;
					hitbox.player = bashed_id.player;
					hitbox.head_obj = self;
					hitbox.projectile_parry_stun = false;
					
					has_hit = false;
					moving_vertically = (hsp == 0)
				}
				
				// Update hitbox
				if (hitbox != noone) {
					hitbox.length++; // Lifetime extender
					hitbox.x = x;
					hitbox.y = y-30;
					hitbox.hsp = hsp;
					hitbox.vsp = vsp;
					
					if (hitbox.has_hit == true) has_hit = true;
				}
				
				spawn_ash_particle(player*3, player*3+1);
				
				// Explode detection
				if (hitstop <= 0 && (window_timer > 32 || hsp == 0 && !moving_vertically || !free || has_hit)) {
					window = 3;
					window_timer = 0;
				}
				
				break;
				
			case 3:
				sprite_index = sprite_get("skullactive");
				image_index = 4 + (window_timer/3)%4;
				
				spawn_ash_particle(player*3, player*3+1);
				
				if (window_timer > 6) {
					window = 4;
					window_timer = 0;
				}
			
			case 4:
				sprite_index = sprite_get("null");
				state = 5;
				state_timer = 0;
				hsp = 0;
				vsp = 0;
				respawn_penalty = true;
				var hbox = create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				hbox.player = bashed_id.player;
				hbox.head_obj = self;
				hbox.projectile_parry_stun = false;
				break;
			
		}
		
		break;
	//#endregion
	
	//#region State 4: Dying ---------------------------------------------------
	case 4:
		hsp = 0;
		vsp = 0;
		
		sprite_index = sprite_get("skulldie");
		can_fspecial = false;
		
		image_index = state_timer / 5;
		if (image_index >= 6) {
			state = 5;
			state_timer = 0;
			sprite_index = sprite_get("null");
		}
		
		// TODO: add sfx
		
		break;
	//#endregion
	
	//#region State 5: Respawning ----------------------------------------------
	case 5:
		
		visible = true;
		ignores_walls = true;
		if (state_timer < 10) sprite_index = sprite_get("null");
		else {
			sprite_index = (state_timer < 16) ? sprite_get("wispstart") : sprite_get("wisp");
			image_index = (state_timer < 16) ? (state_timer-10)/3 :(state_timer-16)/5;
		}
		
		can_fspecial = false;
		
		var delay_total =  (respawn_penalty ? penalty_delay : respawn_delay);
		
		if (state_timer == 1) {
			duration = -1;
			respawn_init_x = x;
			respawn_init_y = y;
		}
		
		if (state_timer == delay_total) {
			if respawn_give_bullet for (var i = 0; i < 2; i++) {
				var wisp = instance_create(x, y-20, "obj_article3");
				wisp.state = 30;
				wisp.height = (-25+(50*i))*clamp(point_distance(x, y, player_id.x, player_id.y-26)/100, 1, 4);
				wisp.y_target_offset = 50;
			}
			duration = point_distance(x, y, player_id.x, player_id.y-26)/10;
		}
		
		else if (state_timer > delay_total) {
			x = respawn_init_x + (player_id.x-respawn_init_x)*(state_timer-delay_total)/duration;
			y = respawn_init_y + (player_id.y-26-respawn_init_y)*(state_timer-delay_total)/duration;
			if (state_timer%5 == 0) spawn_hit_fx(x, y, player_id.vfx_wisp_end)
		}
		
		if (duration != -1 && state_timer > duration + delay_total) {
			var regen_vfx = spawn_hit_fx(player_id.x+(4*player_id.spr_dir), player_id.y-56, player_id.vfx_bullseye_small);
			regen_vfx.depth = player_id.depth-1;
			sound_play(asset_get("sfx_mol_bombpop"));
			state = 0;
			state_timer = 0;
			visible = false;
			
			var end_vfx = spawn_hit_fx(x, y, player_id.vfx_wisp_end);
			end_vfx.depth = depth;
			
			// Respawn give bullet moved to inactive state
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
					player_id.move_cooldown[AT_FSPECIAL] = 45;
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
		
		visible = true;
	    can_fspecial = false;
		
		hsp *= 0.9;
		vsp *= 0.9;
		
		switch window {
			
			case 1:
				sprite_index = sprite_get("skullactive");
				image_index = 4;
				
				spawn_ash_particle(player*3, player*3+1);
				
				if (window_timer > 6) {
					state = 2;
					state_timer = 0;
				}
			
			case 2:
				spawn_ash_particle(player*3, player*3+1);
				state = 5;
				state_timer = 0;
				hsp = 0;
				vsp = 0;
				sprite_index = sprite_get("null");
				respawn_penalty = false;
				var hbox = create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				hbox.head_obj = self;
				break;
		}
		
		break;
		
	//#endregion
	
	//#region Command Attack: AT_FTHROW ------------------------------------------------
	case AT_FTHROW:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    can_fspecial = false;
		
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
				sprite_index = sprite_get("null");
				state = 5;
				state_timer = 0;
				hsp = 0;
				vsp = 0;
				respawn_penalty = false;
				var hbox = create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				hbox.head_obj = self;
				break;
			
		}
		
		break;	
	
	//#endregion
	
	//#region Command Attack: AT_UTHROW ------------------------------------------------
	case AT_UTHROW:
		visible = true;
	    sprite_index = sprite_get("skullactive");
	    can_fspecial = false;
		
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
				sprite_index = sprite_get("null");
				state = 5;
				state_timer = 0;
				hsp = 0;
				vsp = 0;
				respawn_penalty = false;
				var hbox = create_hitbox(AT_FSPECIAL_2, 1, x+(4*spr_dir), y-32);
				hbox.head_obj = self;
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
			
				hittable = false;
				
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
				if (window_timer >= 10) {
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
					hsp = 0;
					vsp = 0;
					respawn_penalty = false;
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



//#region Supersonic Hit Detection

#define on_hit(hbox)
// This is the code the article should run on hit.
// Edit this to have the desired functions when your article is hit by a hitbox.
// hbox refers to the pHitBox object that hit the article.
// hit_player_obj (usually) refers to the player that hit the article.
// hit_player_num refers to the player's number that hit the article.
 
hit_player_obj = hbox.player_id;
hit_player_num = hbox.player;
 
//Default Hitpause Calculation
//You probably want this stuff because it makes the hit feel good.
if hbox.type == 1 {
    var desired_hitstop = clamp(hbox.hitpause + hbox.damage * hbox.hitpause_growth * 0.05, 0, 20);
    with hit_player_obj {
        if !hitpause {
            old_vsp = vsp;
            old_hsp = hsp;
        }
        hitpause = true;
        has_hit = true;
        if hitstop < desired_hitstop {
            hitstop = desired_hitstop;
            hitstop_full = desired_hitstop;
        }
    }
}
// This puts the ARTICLE in hitpause.
// If your article does not already account for being in hitpause, either make it stop what it's doing in hitpause
// or comment out the line below.
hitstop = floor(desired_hitstop); 
 
//Hit Lockout
if article_should_lockout hit_lockout = hbox.no_other_hit;
 
//Default Hitstun Calculation
hitstun = (hbox.kb_value * 4 * ((kb_adj - 1) * 0.6 + 1) + hbox.damage * 0.12 * hbox.kb_scale * 4 * 0.65 * kb_adj) + 12;
hitstun_full = hitstun;
            
//Default Knockback Calculation
 
// if other.force_flinch && !other.free orig_knock = 0; //uncomment this line for grounded articles.
if hbox.force_flinch orig_knock = 0.3; //comment out this line for grounded articles.
else orig_knock = hbox.kb_value + hbox.damage * hbox.kb_scale * 0.12 * kb_adj;
kb_dir = get_hitbox_angle(hbox);
 
hsp = lengthdir_x(orig_knock, kb_dir);
vsp = lengthdir_y(orig_knock, kb_dir);

//Default hit stuff
sound_play(hbox.sound_effect);
//ty nart :p
var fx_x = lerp(hbox.x, x, 0.5) + hbox.hit_effect_x*hbox.spr_dir;
var fx_y = lerp(hbox.y, y, 0.5) + hbox.hit_effect_y;
with hit_player_obj { // use a with so that it's shaded correctly
    var temp_fx = spawn_hit_fx(fx_x, fx_y, hbox.hit_effect);
    temp_fx.hit_angle = other.kb_dir;
    temp_fx.kb_speed = other.orig_knock;
}

// SK bounce for fun~
if (hbox.player_id.url == CH_SHOVEL_KNIGHT && hbox.attack == AT_DAIR && hbox.type == 1) {
    if (hbox.player_id.vsp > -5) hbox.player_id.vsp = -5;
    if (hbox.player_id.old_vsp > -5) hbox.player_id.old_vsp = -5;
    if (hbox.hbox_num == 3) sound_play(asset_get("sfx_shovel_hit_light1")); // idk why this one doesn't have sfx lol
}
 
//State stuff
state = 2;
state_timer = 0;
moving_vertically = (hsp == 0);
sprite_index = sprite_get("skull_hurt");


#define filters(hbox)
//These are the filters that check whether a hitbox should be able to hit the article.
//Feel free to tweak this as necessary.
with hbox {
    var player_equal = player == other.player_id.player;
    var team_equal = get_player_team(player) == get_player_team(other.player_id.player);
    
    return ("owner" not in self || owner != other) //check if the hitbox was created by this article
        && hit_priority != 0 && hit_priority <= 10
        && (groundedness == 0 || groundedness == 1+other.free)
        && (!player_equal) //uncomment to prevent the article from being hit by its owner.
        && ( !get_match_setting(SET_TEAMS) || get_match_setting(SET_TEAMATTACK) || !team_equal ) //uncomment to prevent the article from being hit by its owner's team.
        && (effect != 9) //filter polite hitboxes
}
 
#define create_article_hitbox(attack, hbox_num, _x, _y)
//Use this function to easily create hitboxes that ignore the article's hit detection.
var hbox = create_hitbox(attack, hbox_num, floor(_x), floor(_y))
hbox.owner = self;
return hbox;
 
#define hit_detection
//Code by Supersonic#9999
//DO NOT modify this function unless you know what you're doing. This does the actual detection, while
//the other functions determine how and what the hit detection interacts with.
//hbox group management
with (oPlayer)
    if state == clamp(state, 5, 6) && window == 1 && window_timer == 1 {
        other.hbox_group[@ player-1][@ attack] = array_create(10,0);
    }
 
//hit lockout stuff
if hit_lockout > 0 {
    hit_lockout--;
    return;
}
//get colliding hitboxes
var hitbox_list = ds_list_create();
 
var num = instance_place_list(floor(x), floor(y), pHitBox, hitbox_list, false);
var final_hbox = noone;
var hit_variable = `hit_article_${id}`;
if num == 0 {
    ds_list_destroy(hitbox_list);
    return;
}
if num == 1 {
    //no priority checks if only one hitbox is found
    var hbox = hitbox_list[|0]
    var group = hbox.hbox_group
    if hit_variable not in hbox 
        if (group == -1 || ( group != -1 && hbox_group[@ hbox.orig_player-1][@ hbox.attack][@ group] == 0)) {
            if filters(hbox) {
                final_hbox = hbox;
            } else {
                //hitbox doesn't meet collision criteria. since this usually doesn't change, omit it.
                variable_instance_set(hbox, hit_variable, true);
            }
        } else {
            //fake hit if group has already hit; optimization thing
            variable_instance_set(hbox, hit_variable, true);
        }
} else {
    var highest_priority = 0;
    var highest_priority_owner = -1;
    var highest_priority_hbox = noone;
    for (var i = 0; i < ds_list_size(hitbox_list); i++) {
        var hbox = hitbox_list[|i]
        var group = hbox.hbox_group
        if hit_variable not in hbox 
            //group check
            if (group == -1 || ( group != -1 && hbox_group[@ hbox.orig_player-1][@ hbox.attack][@ group] == 0)) {
                if filters(hbox) {
                    if hbox.hit_priority > highest_priority {
                        highest_priority = hbox.hit_priority;
                        highest_priority_owner = hbox.player;
                        highest_priority_hbox = hbox;
                    }
                } else {
                    //hitbox doesn't meet collision criteria. since this usually doesn't change, omit it.
                    variable_instance_set(hbox, hit_variable, true);
                }
            } else {
                //fake hit if group has already hit; optimization thing
                variable_instance_set(hbox, hit_variable, true);
            }
    }
    if highest_priority != 0 {
        final_hbox = highest_priority_hbox;
    }
}
 
if final_hbox != noone {
    on_hit(final_hbox);
    variable_instance_set(final_hbox, hit_variable, true);
    if final_hbox.hbox_group != -1 hbox_group[@ final_hbox.orig_player-1][@ final_hbox.attack][@ final_hbox.hbox_group] = 1;
}
 
//clear hitbox list
//ds_list_clear(hitbox_list)
ds_list_destroy(hitbox_list);

//#endregion

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion