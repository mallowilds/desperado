// attack_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Runs every frame while your character is attacking.
var timer1 = window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) && window == 1 && !hitpause

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse()
}

switch (attack) {
    
    case AT_BAIR: 
    case AT_EXTRA_1:
        if window == 1 && window_timer == 1 && !hitpause {
            sound_play(sound_get("desp_whip"), 0, noone, .8, 1 )
        }
    break;    
    
    case AT_DSPECIAL:
        set_attack_value(attack, AG_USES_CUSTOM_GRAVITY, (vsp > 0));
        if (vsp > 3) vsp = 3;
        hsp = clamp (hsp, -2.5, 2.5);
        can_fast_fall = false;
        
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
        
        if (special_down && (down_down || down_stick_down) && window == 3 && window_timer = get_window_value(attack, window, AG_WINDOW_LENGTH)) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
            window = 1;
            window_timer = 0;
        }
        
    break;
    
    case AT_NSPECIAL:
        
        if (window == 1 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) && !hitpause) {
            sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1)
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
                    window = 3;
                    window_timer = 0;
                }
            }
            
            //sound_play(sound_get("desp_whip"), 0, noone, 2, 1.05)
        }
        
        if (window == 2 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) && !hitpause) {
            sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1)
            sound_play(sound_get("desp_shot"))
            attack_end()
            num_bullets--;
            if (num_bullets > 0) {
                window = 2;
                window_timer = 0;
            }
        }
        
        // Hitbox handling
        if (window == 2 && window_timer == 1 && !hitpause) {
            
            
            // Set initial hitboxes
            var shot_loops = 0;
            var shot_x = get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X);
            var shot_y = get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_Y);
            var shot_hb_w = get_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH);
            var shot_hb_h = get_hitbox_value(AT_NSPECIAL, 1, HG_HEIGHT);
            
            while (!centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_loops < 20) {
                
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_PARENT_HITBOX, 1);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, 2, HG_LIFETIME));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_X, shot_x);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_Y, shot_y);
                
                shot_hbox = create_hitbox(attack, 3+shot_loops, x+(shot_x*spr_dir), y+shot_y);
                
                shot_loops++;
                shot_x += shot_hb_w;
                
            }
            
            // Create sunken hitbox
            while (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_hb_w > 0) {
                shot_hb_w -= 2;
                if (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block"))) shot_x -= 1;
            }
            
            if (shot_hb_w > 0) {
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_PARENT_HITBOX, 0);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_TYPE, get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_TYPE));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, 1, HG_LIFETIME));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_X, shot_x);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_Y, shot_y);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_WIDTH, shot_hb_w);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HEIGHT, shot_hb_h);
                for (var i = 9; i <= 57; i++) set_hitbox_value(AT_NSPECIAL, 3+shot_loops, i, get_hitbox_value(AT_NSPECIAL, 1, i));
                
                shot_hbox = create_hitbox(attack, 3+shot_loops, x+(shot_x*spr_dir), y+shot_y);
            }
            
            // Set up visual
            var shot_end_x = shot_x+shot_hb_w/2;
            shot_x = get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X);
            shot_hb_w = get_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH);
            
            var shot_visual = {
                sp_x : x + (shot_x - shot_hb_w/2)*spr_dir + hsp,
                sp_y : y + shot_y + vsp,
                sp_length : shot_end_x - (shot_x - shot_hb_w/2),
                sp_tile_index : sprite_get("nspec_beam_segment"),
                sp_tile_height : 32, // Hardcoded. Not ideal but y'know
                sp_edge_index : sprite_get("nspec_beam_end"),
                sp_edge_width : 32, // Again, hardcoded. Update to match the sprite as needed
                sp_max_lifetime : 4,
                sp_lifetime : 0,
                sp_spr_dir : spr_dir
            };
            ds_list_add(nspec_shot_list, shot_visual);
            
        }
        
        if (window == 3 && window_timer == 1 && !hitpause) {
            
            // Set initial hitboxes
            var shot_loops = 0;
            var shot_x = get_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_X);
            var shot_y = get_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_Y);
            var shot_hb_w = get_hitbox_value(AT_NSPECIAL, 2, HG_WIDTH);
            var shot_hb_h = get_hitbox_value(AT_NSPECIAL, 2, HG_HEIGHT);
            
            while (!centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_loops < 20) {
                
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_PARENT_HITBOX, 2);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, 2, HG_LIFETIME));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_X, shot_x);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_Y, shot_y);
                
                shot_hbox = create_hitbox(attack, 3+shot_loops, x+(shot_x*spr_dir), y+shot_y);
                
                shot_loops++;
                shot_x += shot_hb_w;
                
            }
            
            // Create sunken hitbox
            while (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block")) && shot_hb_w > 0) {
                shot_hb_w -= 2;
                if (centered_rect_meeting(x+(shot_x*spr_dir), y+shot_y, shot_hb_w, shot_hb_h, asset_get("par_block"))) shot_x -= 1;
            }
            
            if (shot_hb_w > 0) {
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_PARENT_HITBOX, 0);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_TYPE, get_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_TYPE));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_LIFETIME, get_hitbox_value(AT_NSPECIAL, 2, HG_LIFETIME));
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_X, shot_x);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HITBOX_Y, shot_y);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_WIDTH, shot_hb_w);
                set_hitbox_value(AT_NSPECIAL, 3+shot_loops, HG_HEIGHT, shot_hb_h);
                for (var i = 9; i <= 57; i++) set_hitbox_value(AT_NSPECIAL, 3+shot_loops, i, get_hitbox_value(AT_NSPECIAL, 2, i));
                
                shot_hbox = create_hitbox(attack, 3+shot_loops, x+(shot_x*spr_dir), y+shot_y);
            }
            
            // Set up visual
            var shot_end_x = shot_x+shot_hb_w/2;
            shot_x = get_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X);
            shot_hb_w = get_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH);
            
            var shot_visual = {
                sp_x : x + (shot_x - shot_hb_w/2)*spr_dir + hsp,
                sp_y : y + shot_y + vsp,
                sp_length : shot_end_x - (shot_x - shot_hb_w/2),
                sp_tile_index : sprite_get("nspec_beam_segment"),
                sp_tile_height : 32, // Hardcoded. Not ideal but y'know
                sp_edge_index : sprite_get("nspec_beam_end"),
                sp_edge_width : 32, // Again, hardcoded. Update to match the sprite as needed
                sp_max_lifetime : 4,
                sp_lifetime : 0,
                sp_spr_dir : spr_dir
            };
            ds_list_add(nspec_shot_list, shot_visual);
            
        }
        
        
        break;
    case AT_USPECIAL:
        can_move = false;
        can_fast_fall = false;
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
    case AT_USTRONG:
        if window > 1 && (window < 5 && window_timer < 17) {
            hud_offset = 60;
        }
    break;
    case AT_DSTRONG:
        can_fast_fall = false
        if window == 1 && window_timer == 1 && !hitpause {
                set_attack_value(AT_DSTRONG, AG_CATEGORY, 0)
                print("reset")
        }
        if !free && ground_type == 2 {
            if (window == 1 && down_pressed) or (window == 2 && strong_charge > 40) {
                set_attack_value(AT_DSTRONG, AG_CATEGORY, 2)
                y += 10;
                window = 7
                window_timer = 0
                strong_charge = 0 
            }
        }
        if window == 7 {
            vsp = 8
            print(window_timer)
            if !free && window_timer > 1 {
                print("y")
                window = 3 
                window_timer = 0;
            }
        }
}


if (attack == AT_FSPECIAL) {
    if (window == 2){
        if (special_pressed) {
            window = 3
            window_timer = 0
            destroy_hitboxes()
        }
    }
    can_fast_fall = false
}


#define centered_rect_meeting(_x, _y, _w, _h, obj)
    return collision_rectangle(_x-(_w/2), _y-(_h/2), _x+(_w/2), _y+(_h/2), obj, false, false);



#define object_meeting(obj1, obj2)
    with (obj1) return place_meeting(x, y, obj2)

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion