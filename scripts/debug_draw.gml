// debug_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#debug-draw-gml
// Meant for development, not final characters.
// Drawn in front of everything else.

//#region Training mode collision visuals
if (get_match_setting(SET_HITBOX_VIS)) {
    
    with (head_obj) {
        if (state != 0 && state != 4 && state != 5) {
            draw_sprite_ext(mask_index, 0, x, y, spr_dir, 1, 0, c_white, 0.5);
        }
    }
    
    if (attack == AT_USPECIAL && window == 2) {
        var _x = get_window_value(AT_USPECIAL, 2, AG_WINDOW_SKULL_GRABBOX_X);
		var _y = get_window_value(AT_USPECIAL, 2, AG_WINDOW_SKULL_GRABBOX_Y);
		var _w = get_window_value(AT_USPECIAL, 2, AG_WINDOW_SKULL_GRABBOX_W);
		var _h = get_window_value(AT_USPECIAL, 2, AG_WINDOW_SKULL_GRABBOX_H);

        draw_set_alpha(0.5);
        draw_rectangle_color(x+((_x-_w/2)*spr_dir), y+(_y-_h/2), x+((_x+_w/2)*spr_dir), y+(_y+_h/2), /*#*/$ff00ff, /*#*/$ff00ff, /*#*/$ff00ff, /*#*/$ff00ff, false);
        draw_set_alpha(1);
    }
    
}
//#endregion