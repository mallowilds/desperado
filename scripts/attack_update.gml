// attack_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Runs every frame while your character is attacking.

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL || attack == AT_DAIR){
    trigger_b_reverse()
}



switch (attack) {
	
	//#region Intro ------------------------------------------------------------
    case 2: //intro
        if window == 1 && (window_timer == 39 || window_timer == 55) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
            sound_play(asset_get("sfx_kragg_spike"), 0, noone, .3, 1.1)
        }
        if window == 2 {
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
    break;
    //#endregion
    
    
    //#region Grounded Normals / Strongs ---------------------------------------
    
    case AT_DTILT:
        down_down = true;			// huh?
        move_cooldown[AT_DTILT] = 1 // ????
    	break;
    case AT_FTILT:
    	if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
    		sound_play(sound_get("sfx_snb_clothes"))
    	}
    	break;
    
    case AT_USTRONG:
        if (window > 1 && (window < 5 && window_timer < 17)) {
            hud_offset = 60;
        }
    	break;
    case AT_DSTRONG:
        if (attack_down) num_bullets = 6; // Temp debugging utility
        break;
        
    case AT_FSTRONG:
    	break;
    case AT_FSTRONG_2:
		if (window == 1 && window_time_is(1)) {
			sound_play(sound_get("desp_spin"));
		}
		if (window == 3 && window_time_is(1)) {
			sound_stop(sound_get("desp_spin"));
			sound_play(asset_get("sfx_mol_distant_explode"), false, noone, 2);
			num_bullets--;
		}
		if (window == 3 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
			fstrong_blast_obj = spawn_hit_fx(x+(70*spr_dir), y-50, vfx_fstrong_blast);
			fstrong_blast_obj.spr_dir = spr_dir;
		}
		
		if (hitpause && instance_exists(fstrong_blast_obj)) {
			fstrong_blast_obj.step_timer--; // manual hitpause
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
                set_state(PS_IDLE_AIR)
            }
        }
    	break;

	case AT_FAIR:

        if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
           sound_play(sound_get("desp_breathsmall"))
        }
    	break;

	case AT_BAIR: 
    case AT_EXTRA_1: // empowered bair 

        if (window == 1 && window_time_is(1)) {
            sound_play(sound_get("desp_whip"), 0, noone, .8, 1 );
        }
    	break;    
    
    case AT_UAIR:
    	break;
    
    //#region AT_DAIR
    case AT_DAIR:
        
        can_wall_jump = true;
        can_move = false;
        move_cooldown[AT_DAIR] = 10;
        if (window == 1) {
        	if (vsp > -1.5) vsp = -1.5;
        }
        
        if (window == 2 && window_timer == 1 && !hitpause) {
        	hsp = 5 * spr_dir;
        	vsp = fast_falling ? 9 : 11;
        }
        
        if (window == 2 && !hitpause) do_skull_grabbox(4);
        
        if (window < 4 && has_hit && !hitpause) {
        	window = 4;
        	window_timer = 0;
        	destroy_hitboxes();
        }
        
        if (window == 4) {
        	can_fast_fall = false;
        	fast_falling = false;
        	if (window_timer == 0 && !hitpause) vsp = -8
        }

        break;
    //#endregion
    	
    //#endregion
    
    
    //#region Neutral Special --------------------------------------------------
    
    case AT_NSPECIAL:
        can_move = false
        can_fast_fall = false
        if window == 1 {
        	if window_timer == 1 && !hitpause && num_bullets > 0 {
        		var vflash = spawn_hit_fx(x, y, vfx_flash)
        		vflash.depth = depth - 1;
        		sound_play(sound_get("desp_sharpen"))
        	}
            var window_len = get_window_value(attack, window, AG_WINDOW_LENGTH);
            if (window_time_is(1)) {
                start_hsp = hsp;
                start_vsp = vsp;
                
            }
            hsp = lerp(hsp, 0, window_timer/window_len);
            vsp = lerp(vsp, 0, window_timer/window_len);
        }
        if window == 2 || (window == 3 && window_timer < 6){
            vsp = 0
            hsp = 0 
        }
        if (window == 1 && window_time_is(get_window_value(attack, window, AG_WINDOW_LENGTH))) {
            
            sound_play(sound_get("desp_shot"))
            
            set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK, 6 + (0.25 * num_bullets));
            set_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING, 0.7 + (0.05 * num_bullets));
            //print(get_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING))
            //print(get_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK))
            
            if (num_bullets <= 0) { // temp override. TODO: replace with proper fail fire
                window = 4;
                window_timer = 0;
            }
            else {
                num_bullets--;
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
            
            num_bullets--;
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
				if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) - 2 {
					sound_play(asset_get("sfx_spin"));
				} else if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) {
					set_head_state(AT_FSPECIAL);
					head_obj.window = 2;
					head_obj.window_timer = 1;
					head_obj.spr_dir = spr_dir;
					head_obj.x = x+(48*spr_dir);
					head_obj.y = y-16;
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
		switch(window){
			case 1:
				if (window_time_is(1) && head_obj.can_fspecial) {
					set_head_state(AT_FSPECIAL);
					head_obj.spr_dir = spr_dir;
				}
				if !free {
					set_window_value(AT_FSPECIAL_2, 2, AG_WINDOW_VSPEED, 0)
				} else {
					set_window_value(AT_FSPECIAL_2, 2, AG_WINDOW_VSPEED, -3)
				}
				break;
			case 2:

				break;
			case 3:
				break;
		}
		break;
	
	//#endregion
	
	
	//#region Up Special -------------------------------------------------------
	
    case AT_USPECIAL:
    
    	if window == 3 { can_fast_fall = true }
    	can_move = (window == 3);
    	can_wall_jump = (window != 4);
    	
    	switch window {
    		
    		case 2:
    			// move_cooldown[AT_USPECIAL] = 999;
    			// Hitbox rendered in debug_draw
    			do_skull_grabbox(4);
    			
		        break;
		       
    		case 4:
    			if (window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)) {
    				window = 5;
    				window_timer = 0;
    				hsp = get_window_value(attack, 5, AG_WINDOW_HSPEED) * spr_dir;
    				vsp = get_window_value(attack, 5, AG_WINDOW_VSPEED);
    			}
    			break;
    		
    		case 5:
    			move_cooldown[AT_FSPECIAL] = 30;
    			break;
    		
		}
        
    	break;
    	
    //#endregion	
    
    
    //#region Down Special -----------------------------------------------------
    case AT_DSPECIAL:
        move_cooldown[AT_DSPECIAL] = 70;
    
        set_attack_value(attack, AG_USES_CUSTOM_GRAVITY, (vsp > 0));
        if (window != 3) {
            if (vsp > 3) vsp = 3;
            hsp = clamp (hsp, -2.5, 2.5);
            can_fast_fall = false;
        }
        
        if (window == 1 && window_time_is(1)) {
        	if (vsp > 0) vsp = 0;
        }
        
        else if (window == 2 && window_time_is(1)) {
            sound_play(sound_get("desp_whisper"))

        }
        
        else if (window == 3 && window_time_is(1)) {
            sound_stop(sound_get("desp_spin"))
            sound_play(sound_get("desp_click"))
            //sound_stop(sound_get("desp_whisper"))
            
            if (num_bullets < 6) num_bullets++;
            else create_hitbox(AT_DSPECIAL, 1, x-(4*spr_dir), y-6); // Wasted bullet visual
        }
        
        if (special_down && (down_down || down_stick_down) && window == 3 && window_timer = get_window_value(attack, window, AG_WINDOW_LENGTH) && !hitpause && !free) {
            window = 1;
            window_timer = 4;
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



#define do_skull_grabbox(target_window)
	var _x = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_X);
	var _y = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_Y);
	var _w = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_W);
	var _h = get_window_value(attack, window, AG_WINDOW_SKULL_GRABBOX_H);
	
	if (head_obj.state != 0 && head_obj.state != 4 && head_obj.state != 5 && centered_rect_meeting(x+(_x*spr_dir), y+_y, _w, _h, head_obj, false)) {
    	set_head_state(0);
    	window = target_window;
    	window_timer = 0;
    	destroy_hitboxes();
    }
    
    draw_skull_grabbox = 2;



#define centered_rect_meeting(_x, _y, _w, _h, obj, prec)
    return collision_rectangle(_x-(_w/2), _y-(_h/2), _x+(_w/2), _y+(_h/2), obj, prec, false);


// Generates hitboxes and visuals from an nspecial melee hitboxes.
// edge_width is the length to the point in the edge sprite where it should hit a wall.
#define create_nspec_shot(hbox_num, start_index, tile_index, edge_index, edge_width, shot_lifetime, smoke_index, smoke_time_offset, smoke_lifetime)

    // Set initial hitboxes
    var shot_loops = 0;
    var first_index = get_num_hitboxes(AT_NSPECIAL)+1;
    var shot_x = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_X);
    var shot_y = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_Y);
    var shot_hb_w = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_WIDTH);
    var shot_hb_h = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HEIGHT);
    
    var shot_collides = shot_collision(shot_x, shot_y, shot_hb_w, shot_hb_h); // Helper function, checks for walls and clairen field (see below)
    while (!shot_collides && shot_loops < 20) {
        
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_PARENT_HITBOX, hbox_num);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, hbox_num, HG_LIFETIME));
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_X, shot_x);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_Y, shot_y);
        
        shot_hbox = create_hitbox(attack, first_index+shot_loops, x+(shot_x*spr_dir), y+shot_y);
        
        shot_loops++;
        shot_x += shot_hb_w;
        
        shot_collides = shot_collision(shot_x, shot_y, shot_hb_w, shot_hb_h);        
    }
    
    shot_collides = shot_collision(shot_x, shot_y, shot_hb_w, shot_hb_h);
    while (shot_collides && shot_hb_w > 0) {
    	shot_hb_w -= 2;
    	shot_collides = shot_collision(shot_x, shot_y, shot_hb_w, shot_hb_h);
        if (shot_collides) shot_x -= 1;
		shot_collides = shot_collision(shot_x, shot_y, shot_hb_w, shot_hb_h);
    }
    
    if (shot_hb_w > 0) {
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_PARENT_HITBOX, 0);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_TYPE, get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_TYPE));
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, hbox_num, HG_LIFETIME));
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_X, shot_x);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_Y, shot_y);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_WIDTH, shot_hb_w);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HEIGHT, shot_hb_h);
        for (var i = 9; i <= 57; i++) set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, i, get_hitbox_value(AT_NSPECIAL, hbox_num, i));
        
        shot_hbox = create_hitbox(attack, first_index+shot_loops, x+(shot_x*spr_dir), y+shot_y);
    }
    
    // Set up visual
    var shot_end_x = shot_x+shot_hb_w/2;
    shot_x = get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X);
    shot_hb_w = get_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH);
    
    var shot_visual = {
        sp_x : x + (shot_x - shot_hb_w/2)*spr_dir + hsp,
        sp_y : y + shot_y + vsp,
        sp_length : shot_end_x - (shot_x - shot_hb_w/2),
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


// Helper function for above
#define shot_collision(_x, _y, _w, _h)
	return centered_rect_meeting(x+(_x*spr_dir), y+_y, _w, _h, asset_get("par_block"), false) || centered_rect_meeting(x+(_x*spr_dir), y+_y, _w, _h, asset_get("plasma_field_obj"), true);

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion