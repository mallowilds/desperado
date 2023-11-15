// debug_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#debug-draw-gml
// Meant for development, not final characters.
// Drawn in front of everything else.

//#region Training mode collision visual
if (get_match_setting(SET_HITBOX_VIS)) {
    
    with (obj_article1) {
        if (player == other.player && state != 0) {
            draw_sprite_ext(mask_index, 0, x, y, spr_dir, 1, 0, c_white, 0.5);
        }
    }
    
}
//#endregion