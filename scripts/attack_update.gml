// attack_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Runs every frame while your character is attacking.
var timer1 = window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) && window == 1 && !hitpause

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse()
}

switch (attack) {
    case AT_DSPECIAL:
        if timer1 {
            num_bullets++;
            if num_bullets > 6 num_bullets = 0
        }
        if window == 2 && window_timer == 45 && !hitpause {
            sound_stop(sound_get("desp_spin"))
            sound_play(sound_get("desp_click"))
        }
    break;
    case AT_NSPECIAL:
        if timer1 {
            sound_play(sound_get("desp_weirdgun"), 0, noone, .8, 1)
            //sound_play(sound_get("desp_whip"), 0, noone, 2, 1.05)
            sound_play(sound_get("desp_shot"))
            if (num_bullets > 0) num_bullets--; // Placeholder check 'till proper bullet checks are in
        }
        if (window == 3){
            if (special_pressed) {
                window = 1
                window_timer = 0
            }
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

if (attack == AT_DSPECIAL){
    if (window == 2 && !was_parried){
        can_jump = true
    }
    can_fast_fall = false
    can_move = false
}