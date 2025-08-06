// attack_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Runs every frame while your character is attacking.

// B - Reversals
// (2/21/2024: DAir is now handled manually, see below)
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse()
}



switch (attack) {
	
	//#region Intro ------------------------------------------------------------
    case 2: //intro
    	if (is_genesis) {
    		
    		gen_image_index = get_window_value(attack, window, AG_WINDOW_ANIM_FRAME_START) + get_window_value(attack, window, AG_WINDOW_ANIM_FRAMES)*(window_timer/get_window_value(attack, window, AG_WINDOW_LENGTH));
    		if (get_gameplay_time() % 6 == 0) spawn_genesis_intro_sparkle(get_gameplay_time()%17, get_gameplay_time()%37, x, y);
    		if (get_gameplay_time() % 6 == 3) spawn_genesis_intro_sparkle(get_gameplay_time()%17, get_gameplay_time()%37, genesis_spawn_player_id.x-(50*genesis_spawn_player_id.spr_dir), genesis_spawn_player_id.y);
    	
    		if (window == 1 && window_time_is(15)) {
    			sound_play(sound_get("gen_intro"))
    		}
    		else if (window == 2 && window_time_is(1)) { 
    			sound_play(sound_get("desp_breathsmall"))
	            sound_play(sound_get("desp_swinglow"), 0, noone, .6, .9)
    		}
    		else if (window == 2 && window_time_is(40)) {
    			sound_stop(sound_get("gen_intro"))
    			sound_play(sound_get("gen_intro_2"))
    		}
    		
    	} else {
    		
	        if (window == 1 && window_time_is(39)) {
	            sound_play(sound_get("desp_rockbreak"))
	        }
	        else if (window == 2) {
	            switch (window_timer) {
	                case 1: 
	                   // sound_play(sound_get("desp_whisper"))
	                    sound_play(sound_get("desp_breathsmall"))
	                    sound_play(asset_get("sfx_syl_ustrong_part2"), 0, noone, .6, .9)
	                    sound_play(sound_get("desp_swinglow"), 0, noone, .6, .9)
	                    break;
	                case 11:
	                    sound_play(asset_get("sfx_syl_ustrong_part2"), 0, noone, .6, 1.1)
	                    break;
	                case 31:
	                    sound_play(sound_get("sfx_snb_clothes"))
	                    break;
	            }
	        }
	        
    	}

    break;
    //#endregion
    
    
    //#region Grounded Normals / Strongs ---------------------------------------
    
    case AT_JAB:
    	if (window == 7 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
    		spin_sfx_instance = sound_play(sound_get("desp_spin"));
    		reload_anim_state = 1;
        	reload_anim_timer = 0;
    	}
    	if (window == 9 && window_time_is(floor(13*(has_hit?1:1.5)))) {
    		sound_stop(spin_sfx_instance);
    		spin_sfx_instance = noone;
    		sound_play(sound_get("desp_click"));
    		reload_anim_state = 3;
        	reload_anim_timer = 0;
    		if (num_bullets < 6 && !was_parried) {
    			num_bullets++;
    			nametag_white_flash = 1;
    		}
    		else { // Wasted bullet visual
            	var bullet_casing = instance_create(x+(50*spr_dir), y-34, "obj_article3");
            	bullet_casing.state = 00;
            	bullet_casing.hsp = -2*spr_dir;
            	bullet_casing.vsp = -4;
            }
    	}
    	break;
    case AT_DTILT:
        down_down = true;			// Force uncrouch after endlag...
        move_cooldown[AT_DTILT] = 1	// ...and make sure this doesn't break the buffer
    	break;
    case AT_FTILT:
    	if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
    		sound_play(sound_get("sfx_snb_clothes"))
    	}
    	break;
    case AT_EXTRA_3: //ftilt emp
    	if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
    		sound_play(asset_get("sfx_zetter_fireball_fire"), 0, noone, .7, .9)
    	}
    	break;
    case AT_UTILT:
    	if window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH)) {
    		sound_play(sound_get("desp_smogswing2"))
    	}
    	break;
    case AT_USTRONG:
        if (window > 1 && (window < 5 && window_timer < 17)) {
            hud_offset = 60;
        }
        if window == 2 && window_timer == 3 && !hitpause {
        	sound_play(sound_get("desp_heavyswing"), 0, noone, .4, .95)
        }
    	break;
    case AT_USTRONG_2: 
		if (window > 1 && (window < 5 && window_timer < 17)) {
            hud_offset = 60;
        }
        if window == 2 && window_timer == 3 && !hitpause {
        	sound_play(asset_get("sfx_may_root"), 0, noone, 1, .95)
        	sound_play(sound_get("desp_heavyswing"), 0, noone, .3, .93)
        }
    	break;
    case AT_DSTRONG:
        if window == 2 && window_timer == 2 && !hitpause {
        	sound_play(sound_get("desp_hiss"), 0, noone, 1.5)
        }
        break;

    case AT_FSTRONG:
    	break;
    case AT_FSTRONG_2:
		if (window == 1 && window_time_is(1)) {
			bullet_lost = false;
			reload_anim_state = 1;
			reload_anim_timer = 0;
			spin_sfx_instance = sound_play(sound_get("desp_spin"));
			fstrong_blast_obj = noone;
		}
		if (window == 3 && window_time_is(1)) {
			sound_stop(spin_sfx_instance);
			spin_sfx_instance = noone;
			sound_play(sound_get("desp_cointoss"), false, noone, 1)
			
			bullet_lost = true;
			num_bullets--;
			nametag_white_flash = 1;
			
			reload_anim_state = 3;
			reload_anim_timer = 0;
		}
		if (window == 3 && window_time_is(11)){
			sound_play(sound_get("desp_coin"), false, noone, .5)
			sound_play(sound_get("desp_blast_fstrong"), 0, noone, .8, 1)	
		}
		if (window == 4 && window_time_is(1)) {
			fstrong_blast_obj = spawn_hit_fx(x+(64*spr_dir), y-50, vfx_fstrong_blast);
			fstrong_blast_obj.spr_dir = spr_dir;
		}
		
		if (hitpause && instance_exists(fstrong_blast_obj)) {
			fstrong_blast_obj.step_timer--; // manual hitpause
		}
    	break;
    	case AT_DATTACK:
    	case AT_EXTRA_2:
    		if window < 4 && has_hit {
    		//	can_ustrong = true;
    		}
    	break;
    //#endregion
    
    
    //#region Aerials ----------------------------------------------------------
    	
    case AT_NAIR:

        if window == 3 {
            if attack_pressed || (window_timer > 5 && attack_down) {
                window = 4
                window_timer = 1
            }
            if window_timer == get_window_value(AT_NAIR, 3, AG_WINDOW_LENGTH) && !hitpause {
                attack_end();
                if (was_parried) set_state(PS_PRATFALL);
                else set_state(PS_IDLE_AIR);
            }
        }
    	break;

	case AT_FAIR:

        if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
           sound_play(sound_get("desp_breathsmall"))
        }
    	break;

	case AT_BAIR: 
        if (window == 1 && window_time_is(1)) {
            bair_sfx_instance = sound_play(sound_get("desp_whip"), 0, noone, .8, 1 );
        }
    	break;
    case AT_EXTRA_1: 
    	if (window == 1 && window_time_is(1)) {
            sound_play(sound_get("desp_whip"), 0, noone, .8, 1 );
        }
    	if window == 1 && window_timer == get_window_value(AT_BAIR, 1, AG_WINDOW_LENGTH) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
    		sound_play(sound_get("desp_firebair"), 0, noone, .4, 1)
    	}
    	break;
    
    case AT_UAIR:
    	if window == 1 && window_time_is(7) {
    		sound_play(sound_get("desp_smogswing"), 0, noone, .8, .9)	
    	}
    	break;
    
    //#region AT_DAIR
    case AT_DAIR:
        
        can_wall_jump = true;
        can_move = false;
        move_cooldown[AT_DAIR] = 10;
        
        switch window {
        	
        	case 1:
        		set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 3);
	        	if (vsp > -1.5) vsp = -1.5;
	        	skull_grabbed = false;
	        	grabbed_player_obj = noone
	        	
		        if (window_timer <= 6){
		        	var dir = (right_down - left_down) + (right_stick_pressed - left_stick_pressed);
		        	dir = clamp(dir, -1, 1);
		            if (dir != 0 && dir == -spr_dir){
		                spr_dir = dir;
		            }
		        }
	        	
	        	// Accomodating for script order issues \/
	        	if (window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) draw_skull_grabbox = 2;
	        	
	        	break;
	        
	        case 2:
	        	if (window_time_is(1)) {
	        		hsp = 5 * spr_dir;
        			vsp = fast_falling ? 9 : 11;
	        	}
	        	
	        	if (!hitpause) {
	        		do_skull_grabbox(get_hitbox_value(AT_DAIR, 1, HG_BASE_HITPAUSE), asset_get("sfx_blow_medium3"));
		        	if (skull_grabbed) {
		        		set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 6);
		        		window = 4;
				    	window_timer = 0;
				    	old_vsp = -8;
				    	destroy_hitboxes();
		        	}
	        	}
	        	// no break
	        
	        case 3:
	        	if (skull_grabbed || (has_hit && !hitpause)) {
	        		set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 6);
		        	window = 4;
		        	window_timer = 0;
		        	vsp = -8;
		        	destroy_hitboxes();
	        	}
	        	break;
	        
	        case 4:
	        	if window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH)) {
    				sound_play(sound_get("desp_heavyswing"), 0, noone, .2, 1.05)
	        	}
	        	can_fast_fall = false;
        		fast_falling = false;
        		
        		if (instance_exists(grabbed_player_obj)) {
        			
        			if (grabbed_player_obj.state = PS_DEAD || grabbed_player_obj.state = PS_RESPAWN) {
        				grabbed_player_obj = noone;
        			}
        			
        			else {
        				grabbed_player_obj.x += x + (40*spr_dir) + hsp;
	    				grabbed_player_obj.x /= 2;
	    				grabbed_player_obj.y += y - 20 + vsp;
	    				grabbed_player_obj.y /= 2;
	    				grabbed_player_obj.hurtboxID.x = grabbed_player_obj.x;
	    				grabbed_player_obj.hurtboxID.y = grabbed_player_obj.y;
	    				grabbed_player_obj.hitstop++;
	    				grabbed_player_obj.fall_through = true;
        			}
    				
    			}
        		
        		if (skull_grabbed && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
					set_head_state(AT_UTHROW);
					head_obj.x = x + (46*spr_dir);
					head_obj.y = y - 24;
					head_obj.spr_dir = spr_dir;
					head_obj.visible = true;
					head_obj.sprite_index = sprite_get("skullactive");
				}
        		
        		break;
        		
        	case 5:
        	case 6:
	        	can_fast_fall = false;
        		fast_falling = false;
        		break;
        		
        }
        	
        break;
    //#endregion
    	
    //#endregion
    
    
    //#region Neutral Special --------------------------------------------------
    
    case AT_NSPECIAL:
        can_move = false
        can_fast_fall = false
        if window == 1 {
        	if (window_timer == 1 && !hitpause && num_bullets > 0) {
        		if head_obj.state == 0 {
	        		var vflash = spawn_hit_fx(x, y, vfx_flash)
	        		vflash.depth = depth - 1;
	        		vflash.follow_id = self
	        		vflash.follow_time = 1000;
        		}
        		sound_play(sound_get("desp_sharpen"))
        	}
        	if (window_time_is(1)) {
                start_hsp = hsp;
                start_vsp = vsp;
                move_cooldown[AT_NSPECIAL] = 999; // anti-stall, reset in update/got_hit/death.gml
                
            }
            var window_len = get_window_value(attack, window, AG_WINDOW_LENGTH);
            hsp = lerp(hsp, 0, window_timer/window_len);
            vsp = lerp(vsp, 0, window_timer/window_len);
            if (window_timer = window_len-1) {
            	skull_latched = (head_obj.state == AT_EXTRA_1);
            }
        }
        if window == 2 || (window == 3 && window_timer < 6){
            vsp = 0
            hsp = 0 
        }
        if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
            set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK, 8 + (0.25 * num_bullets));
            set_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING, 0.75 + (0.05 * num_bullets));
            //print(get_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING))
            //print(get_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK))
            
            if (num_bullets <= 0) {
                window = 9;
                window_timer = 0;
                sound_play(sound_get("desp_smallclick"))
                sound_play(sound_get("desp_snap"))
            }
            else {
                sound_play(sound_get("desp_shot"))
                num_bullets--;
                nametag_white_flash = 1;
                
                reload_anim_state = 4;
        		reload_anim_timer = 0;
        		
                if (num_bullets <= 0) {
                    sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1);
                    window = 3;
                    window_timer = 0;
                    create_nspec_shot(2, sprite_get("nspec_blast_close"), sprite_get("nspec_blast_segment"), sprite_get("nspec_blast_wall"), 38, 6, sprite_get("nspec_blast_smoke"), -2, 24);
                }
                else {
                	create_nspec_shot(1, sprite_get("nspec_blast_close"), sprite_get("nspec_blast_segment"), sprite_get("nspec_blast_wall"), 38, 6, sprite_get("null"), 0, 0);
                }
            }
            
            //sound_play(sound_get("desp_whip"), 0, noone, 2, 1.05)
        }
        
        if (window == 2 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
            
            sound_play(sound_get("desp_shot"))
            
            reload_anim_state = 4;
        	reload_anim_timer = 0;
        	
            num_bullets--;
            nametag_white_flash = 1;
            if (num_bullets > 0) {
                window = 2;
                window_timer = 0;
                attack_end();
                create_nspec_shot(1, sprite_get("nspec_blast_close"), sprite_get("nspec_blast_segment"), sprite_get("nspec_blast_wall"), 38, 6, sprite_get("null"), 0, 0);
            }
            else { // Continuing to window 3
                sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1);
                attack_end();
                create_nspec_shot(2, sprite_get("nspec_blast_close"), sprite_get("nspec_blast_segment"), sprite_get("nspec_blast_wall"), 38, 6, sprite_get("nspec_blast_smoke"), -2, 24);
            }
        }
    	
        break;
        
    //#endregion
    
        
    //#region Forward Special --------------------------------------------------
    
    case AT_FSPECIAL:
		can_move = false;
		can_fast_fall = false;
		switch(window){
			case 1:
				if !free {
					set_window_value(AT_FSPECIAL, 2, AG_WINDOW_VSPEED, 0)
				} else {
					set_window_value(AT_FSPECIAL, 2, AG_WINDOW_VSPEED, -3)
				}
				
				if (window_timer < 6) {
					fspec_held = special_down;
				}
				
				if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) - 2 {
					sound_play(asset_get("sfx_spin"))
				} else if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) {
					set_head_state(AT_FSPECIAL);
					head_obj.visible = true;
					head_obj.sprite_index = sprite_get("skullactive");
					head_obj.window = 2;
					head_obj.window_timer = 1;
					head_obj.spr_dir = spr_dir;
					head_obj.x = x+(48*spr_dir);
					head_obj.y = y-10;
					head_obj.throw_dir = down_down - up_down;
					head_obj.extend_throw = fspec_held;
				}
				break;
			case 2:
				
				break;
			case 3:
				break;
		}
		break;
	
	case AT_FSPECIAL_2:
		can_move = false;
		can_fast_fall = false;
		switch(window) {
			case 1:
				var head_latched = (head_obj.state == AT_EXTRA_1);
				if (window_timer == 1 && head_latched) {
					// TODO: adjust flash position to be at head's eye socket
	        		var vflash = spawn_hit_fx(head_obj.x, head_obj.y, vfx_flash);
	        		vflash.depth = head_obj.depth - 1;
	        		vflash.follow_id = head_obj;
	        		vflash.follow_time = 1000;
        			sound_play(sound_get("desp_sharpen"));
				}
				else if (window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)-1) {
					set_window_value(AT_FSPECIAL_2, 2, AG_WINDOW_VSPEED, fspecial_command_boosts[free*(1+head_latched)]);
				}
				break;
			case 2:
				if (window_time_is(1) && head_obj.can_fspecial) {
					set_head_state(AT_FSPECIAL_2);
					head_obj.has_hit = false;
					head_obj.spr_dir = spr_dir;
					head_obj.target_id = noone;
				}
				break;
		}
		break;
	
	//#endregion
	
	
	//#region Up Special -------------------------------------------------------
	
    case AT_USPECIAL:
    
    	can_fast_fall = false;
    	can_move = (window == 3);

    	switch window {
    		
    		case 1:
    			can_wall_jump = true;
    			
    			if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) {
    				sound_play(sound_get("desp_grabswing"))
    			}
    			set_attack_value(AT_USPECIAL, AG_NUM_WINDOWS, 3);
    			grabbed_player_obj = noone;
    			skull_grabbed = false;
    			// Accomodating for script order issues \/
        		if (window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) draw_skull_grabbox = 2;
    			break;
    		
    		case 2:
    			can_wall_jump = !(instance_exists(grabbed_player_obj) || skull_grabbed);
    			
    			do_skull_grabbox(get_hitbox_value(AT_USPECIAL, 1, HG_BASE_HITPAUSE), asset_get("sfx_blow_medium3"));
    			
    			if (instance_exists(grabbed_player_obj)) {
    				
    				if (grabbed_player_obj.state = PS_DEAD || grabbed_player_obj.state = PS_RESPAWN) {
        				grabbed_player_obj = noone;
        			}
        			
        			else {
	    				grabbed_player_obj.x = x + (36*spr_dir) + hsp;
	    				grabbed_player_obj.y = y - 54 + vsp;
	    				grabbed_player_obj.hurtboxID.x = grabbed_player_obj.x;
	    				grabbed_player_obj.hurtboxID.y = grabbed_player_obj.y;
	    				grabbed_player_obj.fall_through = true;
	    				grabbed_player_obj.hitstop++;
        			}
	    			
    			}
    			
    			if (window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH)) && (instance_exists(grabbed_player_obj) || skull_grabbed)) {
					set_attack_value(AT_USPECIAL, AG_NUM_WINDOWS, 5);
					window = 4;
					window_timer = 0;
				}
    			
		        break;
		    
		    case 3:
		    	if (window_time_is(1) && (instance_exists(grabbed_player_obj) || skull_grabbed)) {
					set_attack_value(AT_USPECIAL, AG_NUM_WINDOWS, 5);
					window = 4;
					window_timer = 0;
				}
		    	else can_wall_jump = true;
		    	break;
		    
    		case 4:
    			can_wall_jump = false;
    			
    			if (instance_exists(grabbed_player_obj)) {
    				grabbed_player_obj.x += x - (48*spr_dir) + hsp;
    				grabbed_player_obj.x /= 2;
    				grabbed_player_obj.y += y + 40 + vsp;
    				grabbed_player_obj.y /= 2;
    				grabbed_player_obj.hurtboxID.x = grabbed_player_obj.x;
    				grabbed_player_obj.hurtboxID.y = grabbed_player_obj.y;
    				grabbed_player_obj.hitstop++;
    				grabbed_player_obj.fall_through = true;
    			}
    			
    			if (window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)) {
    				sound_play(sound_get("desp_heavyswing"), 0, noone, .2, 1.05)
    				hsp = get_window_value(attack, 5, AG_WINDOW_HSPEED) * spr_dir;
    				vsp = get_window_value(attack, 5, AG_WINDOW_VSPEED);
    				if (instance_exists(grabbed_player_obj)) {
    					grabbed_player_obj.x = x + (58*spr_dir) + hsp;
    					grabbed_player_obj.y = y - 26 + vsp;
    					grabbed_player_obj.hurtboxID.x = grabbed_player_obj.x;
    					grabbed_player_obj.hurtboxID.y = grabbed_player_obj.y;
    				}
    				
    				if (skull_grabbed) {
	    				set_head_state(AT_FTHROW);
	    				head_obj.x = x + (36*spr_dir);
	    				head_obj.y = y - 20;
	    				head_obj.spr_dir = spr_dir;
	    				head_obj.visible = true;
	    				head_obj.sprite_index = sprite_get("skullactive");
	    			}
    			}
    			break;
    		
    		case 5:
    			break;
    		
    		case 6:
    			break;
    		
		}
        
    	break;
    	
    //#endregion	
    
    
    //#region Down Special -----------------------------------------------------
    case AT_DSPECIAL:
        move_cooldown[AT_DSPECIAL] = 70;
        
        can_move = false
        var dspec_air_drift = 0.2;
        if (free) hsp = clamp(hsp-(dspec_air_drift*left_down)+(dspec_air_drift*right_down), -2, 2);
    
        set_attack_value(attack, AG_USES_CUSTOM_GRAVITY, (vsp > 0));
        
        if (get_match_setting(SET_PRACTICE) && taunt_pressed) training_mode_refill = true;
        
        switch window {
        	
        	case 1:
        		if window_time_is(1) {
        			if (vsp > 0) vsp = 0;
        			training_mode_refill = get_match_setting(SET_PRACTICE) && taunt_pressed;
        			
        			reload_anim_state = 1;
        			reload_anim_timer = 0;
        		}
        		
        		else if (window_time_is(2)) spin_sfx_instance = sound_play(sound_get("desp_spin"));
        		
        		if (vsp > 4) vsp = 4;
	            
	            can_fast_fall = false;
	            
	            break;
			
			case 2:
				if (window_time_is(1)) whisper_sfx_instance = sound_play(sound_get("desp_whisper"));
				
				if (vsp > 4) vsp = 4;
	            can_fast_fall = false;
	            
	            break;
			
			case 3:
				if (window_time_is(1)) {
					sound_stop(spin_sfx_instance);
					spin_sfx_instance = noone;
		            sound_stop(whisper_sfx_instance);
		            whisper_sfx_instance = noone;
		            
		            sound_play(sound_get("desp_click"));
		            
		            reload_anim_state = 3;
        			reload_anim_timer = 0;
		            
		            if (num_bullets < 6) {
		            	num_bullets++;
		            	nametag_white_flash = 1;
		            }
		            else { // Wasted bullet visual
		            	var bullet_casing = instance_create(x-(10*spr_dir), y-8, "obj_article3");
		            	bullet_casing.state = 00;
		            	bullet_casing.hsp = -2*spr_dir;
		            	bullet_casing.vsp = -4;
		            }
		            
		            move_cooldown[AT_NSPECIAL] = 0; // Anti-stall reset
				}
				
				// Training mode refill
				if (training_mode_refill && num_bullets < 6 && window_time_is(2)) {
					window = 2;
					window_timer = 20;
				}
				
				// Loop
				if (window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH) - 4) && special_down && (down_down || down_stick_down) && !free) {
		            window = 1;
		            window_timer = 4;
		            
		            spin_sfx_instance = sound_play(sound_get("desp_spin"));
		            reload_anim_state = 1;
        			reload_anim_timer = 0;
		        }
				
				break;
        	
        }
        
    	break;
    	
    //#endregion
    
    
    //#region Taunt -----------------------------------------------------
    
    case AT_TAUNT:
    	
    	if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH)-3)) {
    		signpost_obj = instance_create(x+(44*spr_dir), y, "obj_article3");
    		signpost_obj.state = 10;
    	}
    	
    	break;
    
    case AT_TAUNT_2:
    
    	var taunt_active = instance_exists(signpost_obj) && signpost_obj.state != 14 && signpost_obj.state != 15 && signpost_obj.state != 17;
    	
    	if (window == 1 && window_time_is(1) && taunt_active) {
    		signpost_obj.state = 16;
    		signpost_obj.state_timer = 0;
    	}
    	
    	if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH)-1)) {
    		if (object_index != oTestPlayer) {
    			var taunt_shot = instance_create(x+(60*spr_dir), y-70, "obj_article3");
    			taunt_shot.state = 20;
    		}
    		else if (taunt_active) { // playtest room behavior
    			signpost_obj.state = 17;
    			signpost_obj.state_timer = 0;
    			sound_play(asset_get("sfx_syl_ustrong_part3"))
                sound_play(asset_get("sfx_ell_drill_stab"))
                var hfx = spawn_hit_fx(signpost_obj.x, signpost_obj.y-50, vfx_bullseye_small);
                hfx.depth = signpost_obj.depth-1;
    		}
    	}
    	
    	break;
    
    case 49: // AT_TAUNT_GEN
    
    	if (window == 1 && window_timer == 1) {
    		genesis_flicker_timer = 0; // Handled by animation.gml
    		sound_play(sound_get("gen_intro_2"));
    	}
    	
    	else if (window == 2) {
    		if (attack_pressed || special_pressed || strong_down || taunt_pressed || shield_pressed || jump_pressed) {
    			window = 3;
    			window_timer = 0;
    			clear_button_buffer(PC_ATTACK_PRESSED);		// yes this is necessary :(
    			clear_button_buffer(PC_SPECIAL_PRESSED);
    			clear_button_buffer(PC_STRONG_PRESSED);
    			clear_button_buffer(PC_JUMP_PRESSED);
    			clear_button_buffer(PC_SHIELD_PRESSED);
    			clear_button_buffer(PC_TAUNT_PRESSED);
    		}
    		
    		if (window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
    			window_timer = 0;
    		}
    	}
    	
    	else if (window == 3) {
    		if (window_timer == 1) genesis_sfx_instance = sound_play(sound_get("gen_intro_2"));
    		if (window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)) sound_stop(genesis_sfx_instance);
    	}
    	
    	break;
    
    //#endregion
    
    
}



#define set_head_state(new_state)
    head_obj.state = new_state;
    head_obj.state_timer = 0;
    head_obj.window = 1;
    head_obj.window_timer = 1;
    return;



// Precondition: skull_grabbed is set to false at start of attack
#define do_skull_grabbox(grab_hitstop, grab_sfx)
	var _x = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_X);
	var _y = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_Y);
	var _w = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_W);
	var _h = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_H);
	
	if (head_obj.state != 0 && head_obj.state != 4 && head_obj.state != 5 && head_obj.state != AT_NSPECIAL && centered_rect_meeting(x+(_x*spr_dir), y+_y, _w, _h, head_obj, false)) {
    	set_head_state(0);
    	skull_grabbed = true;
    	head_obj.visible = false;
    	
    	sound_play(grab_sfx);
    	
    	if (!hitpause) {
    		old_hsp = hsp;
    		old_vsp = vsp;
    	}
    	hitpause = true;
    	if (grab_hitstop > hitstop_full) hitstop_full = grab_hitstop;
    	if (grab_hitstop > hitstop) hitstop = grab_hitstop;
    	
    }
    
    draw_skull_grabbox = 2;



#define centered_rect_meeting(_x, _y, _w, _h, obj, prec)
    return collision_rectangle(_x-(_w/2), _y-(_h/2), _x+(_w/2), _y+(_h/2), obj, prec, false);


// Generates hitboxes and visuals from nspecial melee hitboxes.
// Primarily an interface for the below functions.
// edge_width is the length to the point in the edge sprite where it should hit a wall.
#define create_nspec_shot(hbox_num, start_index, tile_index, edge_index, edge_width, shot_lifetime, smoke_index, smoke_time_offset, smoke_lifetime)
	
    var _h = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HEIGHT);
    var _x = x + spr_dir*nspec_x_pos;
	var _y = y + get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_Y);
	
	var length = get_shot_length(_x, _y, 960, _h);
	
	create_shot_hitbox(nspec_x_pos, length, AT_NSPECIAL, hbox_num);
	create_shot_visual(_x+hsp, _y+vsp-2, length, start_index, tile_index, edge_index, edge_width, shot_lifetime, smoke_index, smoke_time_offset, smoke_lifetime);
	shot_hit_skull(_x, _y, length, _h, (hbox_num == 1 ? vfx_bullseye_small : vfx_bullseye));
	

// Generates furthest rectangular space a shot can occupy.
// (_x, _y) denotes left-center position of rectangle (assuming spr_dir == 1).
#define get_shot_length(_x, _y, max_length, height)
	
	if (spr_dir == 1) max_length = min(max_length, get_stage_data(SD_RIGHT_BLASTZONE_X) - x);
	else max_length = min(max_length, x - get_stage_data(SD_LEFT_BLASTZONE_X));
	
	var lower_bound = 0;
	var upper_bound = max_length;
	var loops = log2(max_length);
	
	var y1 = _y-(height/2);
	var y2 = _y+(height/2);
	
	for (i = 0; i <= loops; i++) {
		var position = (lower_bound+upper_bound)/2;
		var outer_x = _x+(position*spr_dir)
		var x1 = min(_x, outer_x);
		var x2 = max(_x, outer_x);
		// x3 and x4 shift skull collision to its center if it's latched
		var ignore_head = skull_latched && position <= 20;
		var x3 = min(_x, outer_x-20*spr_dir);
		var x4 = max(_x, outer_x-20*spr_dir);
		
		var is_colliding = false;
		is_colliding |= noone != collision_rectangle(x1, y1, x2, y2, asset_get("par_block"), false, false);
		is_colliding |= noone != collision_rectangle(x1, y1, x2, y2, asset_get("obj_clairen_field"), true, false);
		is_colliding |= !ignore_head && head_obj.state != 0 && head_obj.state != 4 && head_obj.state != 5 &&
						noone != collision_rectangle(skull_latched?x3:x1, y1, skull_latched?x4:x2, y2, head_obj, true, false);
		
		if (is_colliding) upper_bound = position;
		else lower_bound = position;
	}
	
	return round(position);


// Lengthens a hitbox to match the given length, then spawns it.
// Places the leftmost edge at _x (assuming spr_dir == 1).
#define create_shot_hitbox(_x, length, atk, hbox_num)

    var shot_x = _x + ceil(length/2);
    set_hitbox_value(atk, hbox_num, HG_HITBOX_X, shot_x);
    set_hitbox_value(atk, hbox_num, HG_WIDTH, length);
    var shot_y = get_hitbox_value(atk, hbox_num, HG_HITBOX_Y);
    
    create_hitbox(atk, hbox_num, x+(shot_x*spr_dir), y+shot_y);
    

// Creates a shot visual object and adds it to the shot rendering list.
// edge_width is the length to the point in the edge sprite where it should hit a wall.
#define create_shot_visual(_x, _y, length, start_index, tile_index, edge_index, edge_width, shot_lifetime, smoke_index, smoke_time_offset, smoke_lifetime)
	
	var shot_visual = {
        sp_x : _x,
        sp_y : _y,
        sp_length : length,
        sp_start_index : start_index,
        sp_tile_index : tile_index,
        sp_edge_index : edge_index,
        sp_edge_width : edge_width,
        sp_shot_lifetime : shot_lifetime,
        sp_smoke_index : smoke_index,
        sp_smoke_time_offset : smoke_time_offset,
        sp_smoke_lifetime : smoke_lifetime,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir
    };
    ds_list_add(nspec_shot_list, shot_visual);


// Check whether a given shot length triggered a skull hit.
#define shot_hit_skull(_x, _y, length, height, hit_vfx)
	
	if (head_obj.state == 0 || head_obj.state == 4 || head_obj.state == 5) return;
	if (head_obj == collision_rectangle(_x+(length*spr_dir)-2, _y-(height/2), _x+(length*spr_dir)+2, _y+(height/2), head_obj, true, true)) {
		set_head_state(AT_NSPECIAL);
    	var vfx = spawn_hit_fx(_x+(length*spr_dir), _y+4, hit_vfx)
    	vfx.depth = min(depth-1, head_obj.depth-1);
    	head_obj.shots_absorbed++;
    	take_damage(player, player, 1)
	}


// used for genesis alt. Differs from normal procedure!
#define spawn_genesis_intro_sparkle(seed1, seed2, in_x, in_y)
	var in_sprite = "fire"+string(random_func_2(seed1, 4, true)+1)+"_gen";
    var x_range = 60;
    var y_range = 70;
    var y_offset = -45;
    var _x = in_x + random_func_2(seed2, x_range, false) - (x_range/2);
    var _y = in_y - random_func_2(seed2+1, y_range, false) + (y_range/2) + y_offset;
    var sparkle = {
        sp_x : _x,
        sp_y : _y,
        sp_sprite_index : sprite_get(in_sprite),
        sp_max_lifetime : 10,
        sp_lifetime : 0,
        sp_spr_dir : 1,
        sp_skull_owned : 0,
    };
    ds_list_add(sparkle_list, sparkle);

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion