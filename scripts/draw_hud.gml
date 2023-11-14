// draw_hud.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-hud-gml
// Used to draw the character's hud.
// The base location of their hud is available as `temp_x` and `temp_y`.


if ("num_bullets" not in self) exit; // Cull error messages on reload


// Gun anim frame management
var frame = 0;
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) {
    if (attack == AT_DSPECIAL) {
        switch window {
            case 1:
                frame = floor(2*window_timer/get_window_value(attack, window, AG_WINDOW_LENGTH));
                break;
            case 2:
                frame = 3 + (window_timer/3)%2;
                break;
            case 3:
                frame = 5 + floor(window_timer/2);
                if (frame >= 9) frame = 0;
                break;
            
        }
    }
    if (attack == AT_NSPECIAL) {
        switch window {
            case 2:
            case 3:
                frame = 10 + (window_timer / 2);
                break;
            case 4:
                frame = 11 + (window_timer / 2);
                if (frame >= 14) frame = 0;
                break;
        }
    }
    
}

// Draw gun
// TODO: fix outline color for GB alt, add color processing on 6 bullets
var player_color = get_player_color(player);
var gun_sprite = sprite_get("desp_hud");

for (var i = 5; i >= num_bullets; i--) {
    set_article_color_slot(i, floor(get_color_profile_slot_r(player_color, 7)*0.75), floor(get_color_profile_slot_g(player_color, 7)*0.75), floor(get_color_profile_slot_b(player_color, 7)*0.75));
}

for (var i = 0; i < num_bullets; i++) {
    set_article_color_slot(i, get_color_profile_slot_r(player_color, 3), get_color_profile_slot_g(player_color, 3), get_color_profile_slot_b(player_color, 3));
}

shader_start();
draw_sprite(gun_sprite, frame, temp_x, temp_y-98);
shader_end();


// Reset article color slots
init_shader();