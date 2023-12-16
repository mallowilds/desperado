// draw_hud.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-hud-gml
// Used to draw the character's hud.
// The base location of their hud is available as `temp_x` and `temp_y`.


if ("num_bullets" not in self) exit; // Cull error messages on reload

//#region Draw gun
// TODO: fix outline color for GB alt
var player_color = get_player_color(player);
var gun_sprite = sprite_get(player_color == 7 ? "desp_hud_ea" : "desp_hud");

for (var i = 5; i >= num_bullets; i--) {
    set_article_color_slot(i, floor(get_color_profile_slot_r(player_color, 7)*0.75), floor(get_color_profile_slot_g(player_color, 7)*0.75), floor(get_color_profile_slot_b(player_color, 7)*0.75));
}

for (var i = 0; i < num_bullets; i++) {
    set_article_color_slot(i, get_color_profile_slot_r(player_color, 3), get_color_profile_slot_g(player_color, 3), get_color_profile_slot_b(player_color, 3));
}

shader_start();
draw_sprite(gun_sprite, reload_anim_frame, temp_x, temp_y-98);
shader_end();
//#endregion


// Reset article color slots
init_shader();

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion