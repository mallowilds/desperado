// draw_hud.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-hud-gml
// Used to draw the character's hud.
// The base location of their hud is available as `temp_x` and `temp_y`.


if ("num_bullets" not in self) exit; // Cull error messages on reload

var player_color = get_player_color(player);
var gun_sprite = sprite_get(player_color == 7 ? "desp_hud_ea" : "desp_hud");

// Early access alt needs special handling~
if (get_player_color(player) != 7) {
    for (var i = 5; i >= num_bullets; i--) {
        set_article_color_slot(i, floor(get_color_profile_slot_r(player_color, 7)*0.75), floor(get_color_profile_slot_g(player_color, 7)*0.75), floor(get_color_profile_slot_b(player_color, 7)*0.75));
    }
    for (var i = 0; i < num_bullets; i++) {
        set_article_color_slot(i, get_color_profile_slot_r(player_color, 3), get_color_profile_slot_g(player_color, 3), get_color_profile_slot_b(player_color, 3));
    }
}
else {
    for (var i = 5; i >= num_bullets; i--) {
        set_article_color_slot(i, 167, 186, 74);
    }
    for (var i = 0; i < num_bullets; i++) {
        set_article_color_slot(i, 89, 145, 58);
    }
}

shader_start();
draw_sprite(gun_sprite, reload_anim_frame, temp_x, temp_y-98);
shader_end();

// Reset article color slots
init_shader();



if (get_match_setting(SET_PRACTICE)) {
    draw_debug_text(temp_x, temp_y-26, "DSPEC+TAUNT:")
    draw_debug_text(temp_x, temp_y-14, "Full reload")
}