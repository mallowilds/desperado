// attack_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Runs every frame while your character is attacking.
var timer1 = window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) && window == 1 && !hitpause

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL || attack == AT_DAIR){
    trigger_b_reverse()
}
switch (attack) {
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
    case AT_BAIR: 
    case AT_EXTRA_1://bair 2
        if window == 1 && window_timer == 1 && !hitpause {
            sound_play(sound_get("desp_whip"), 0, noone, .8, 1 )
        }
    break;    
    case AT_NAIR:
        if window == 3 {
            if attack_pressed || (window_timer > 5 && attack_down) {
                window = 4
                window_timer = 1
            }
            if window_timer == get_window_value(AT_NAIR, 3, AG_WINDOW_LENGTH) && !hitpause{
                attack_end();
                set_state(PS_IDLE_AIR)
            }
        }
    break;
    case AT_DSPECIAL:
        move_cooldown[AT_DSPECIAL] = 70;
    
        set_attack_value(attack, AG_USES_CUSTOM_GRAVITY, (vsp > 0));
        if window != 3 {
            if (vsp > 3) vsp = 3;
            hsp = clamp (hsp, -2.5, 2.5);
            can_fast_fall = false;
        }
        
        if window == 1 && window_timer == 1 { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
            if (vsp > 0) vsp = 0;
        }
        
        if window == 2 && window_timer == 1 && !hitpause {
            sound_play(sound_get("desp_whisper"))

        }
        
        if window == 3 && window_timer == 1 && !hitpause {
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
    
    case AT_NSPECIAL:
        can_move = false
        can_fast_fall = false
        if window == 1 {
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
            set_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING, 0.4 + (0.05 * num_bullets));
            
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
            }
            else { // Continuing to window 3
                sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1);
            }
        }
        
        if (window_time_is(1)) {
            attack_end()
            if (window == 2) create_nspec_shot(1, sprite_get("nspec_beam_segment"), sprite_get("nspec_beam_end"), 32);
            if (window == 3) create_nspec_shot(2, sprite_get("nspec_beam_segment"), sprite_get("nspec_beam_end"), 32);
        }
        
        break;
        
        
    case AT_FSPECIAL:
		can_move = false;
		can_fast_fall = false;
		switch(window){
			case 1:
				if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) - 2 { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					sound_play(asset_get("sfx_spin"));
				} else if window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) {
					set_head_state(AT_FSPECIAL);
					head.window = 2;
					head.spr_dir = spr_dir;
					head.x = x;
					head.y = y-36;
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
				if window_timer == 1 { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
					set_head_state(AT_FSPECIAL);
					head.spr_dir = spr_dir;
				}
				break;
			case 2:
				break;
			case 3:
				break;
		}
		break;
		
	
    case AT_USPECIAL:
    
    	can_fast_fall = false;
    	can_move = (window == 3);
    	can_wall_jump = (window != 4);
    	
    	switch window {
    		
    		case 2:
    			move_cooldown[AT_USPECIAL] = 999;
    			if (position_meeting(x+(36*spr_dir), y-80, head)) {
		        	set_head_state(0);
		        	window = 4;
		        	window_timer = 0;
		        }
		        break;
		       
    		case 4:
    			if (window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)) {
    				window = 5;
    				window_timer = 0;
    				hsp = get_window_value(attack, 5, AG_WINDOW_HSPEED) * spr_dir;
    				vsp = get_window_value(attack, 5, AG_WINDOW_VSPEED);
    			}
    			break;
    		
		}
        
    break;
    
    case AT_DTILT:
        down_down = true;
        move_cooldown[AT_DTILT] = 1 
    break;
    case AT_FAIR:

        if timer1 {
           sound_play(sound_get("desp_breathsmall"))
        }
    break;
    case AT_DAIR:
        
        can_wall_jump = true;
        can_move = false;
        
        // Landing lag
        if (!free && window != 4 && !hitpause) {
            window = 4;
            window_timer = 0;
            destroy_hitboxes();
        }
        
        if (free && window == 4 && !hitpause) {
            attack_end();
            set_state(PS_IDLE_AIR);
            hsp = clamp(hsp, leave_ground_max*-1, leave_ground_max);
        }
        
        
        
        
        if (window == 1 && !hitpause) {
            can_move = false;
            if (window_time_is(1)) {
                stored_fast_fall = false;
                dairs_used++;
            }
            
            if (fast_falling) {
                fast_falling = false;
                can_fast_fall = false;
                stored_fast_fall = true;
                vsp = get_window_value(attack, window, AG_WINDOW_VSPEED);
            }
            
        }
        
        if (window == 2 && (fast_falling || stored_fast_fall) && !hitpause) {
            vsp = 9;
            stored_fast_fall = false;
        }
        
        if (window == 3) {
            
            // Version C: Pause and jump back
            if (!hitpause) {
                if (window_timer == 1) {
                    start_hsp = hsp;
                    start_vsp = vsp;
                }
                if (window_timer < 3) {
                    can_fast_fall = false;
                    hsp = lerp(start_hsp, 2*spr_dir, window_timer/4);
                    vsp = lerp(start_vsp, 0, window_timer/4);
                }
                else if (window_timer == 3) {
                    hsp = 2*spr_dir;
                    vsp = -7*(1/dairs_used);
                }
                else {
                    vsp += gravity_speed;
                    if (left_down)  hsp -= 0.1
                    if (right_down) hsp += 0.1
                }
            }
            
        }
        break;
    case AT_USTRONG:
        if window > 1 && (window < 5 && window_timer < 17) {
            hud_offset = 60;
        }
    break;
    case AT_DSTRONG:
        if attack_down {
            num_bullets = 6
        }
}



#define set_head_state(new_state)
    head.state = new_state;
    head.state_timer = 0;
    head.window = 1;
    head.window_timer = 1;
    return;



#define centered_rect_meeting(_x, _y, _w, _h, obj)
    return collision_rectangle(_x-(_w/2), _y-(_h/2), _x+(_w/2), _y+(_h/2), obj, false, false);


// Generates hitboxes and visuals from an nspecial melee hitboxes.
// edge_width is the length to the point in the edge sprite where it should hit a wall.
#define create_nspec_shot(hbox_num, tile_index, edge_index, edge_width)

    // Set initial hitboxes
    var shot_loops = 0;
    var first_index = get_num_hitboxes(AT_NSPECIAL)+1;
    var shot_x = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_X);
    var shot_y = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HITBOX_Y);
    var shot_hb_w = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_WIDTH);
    var shot_hb_h = get_hitbox_value(AT_NSPECIAL, hbox_num, HG_HEIGHT);
    
    while (!centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_loops < 20) {
        
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_PARENT_HITBOX, hbox_num);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, hbox_num, HG_LIFETIME));
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_X, shot_x);
        set_hitbox_value(AT_NSPECIAL, first_index+shot_loops, HG_HITBOX_Y, shot_y);
        
        shot_hbox = create_hitbox(attack, first_index+shot_loops, x+(shot_x*spr_dir), y+shot_y);
        
        shot_loops++;
        shot_x += shot_hb_w;
        
    }
    
    // Create sunken hitbox
    while (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_hb_w > 0) {
        shot_hb_w -= 2;
        if (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block"))) shot_x -= 1;
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
        sp_tile_index : tile_index,
        sp_edge_index : edge_index,
        sp_edge_width : edge_width,
        sp_max_lifetime : 4,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir
    };
    ds_list_add(nspec_shot_list, shot_visual);

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion