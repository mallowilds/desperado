// other_pre_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#other-pre-draw-gml-and-other-post-draw-gml
// Draws BEHIND all OTHER characters


// Genesis alt
if ("is_genesis" not in other_player_id) exit;
with other_player_id {
    if (is_genesis && other == genesis_spawn_player_id && attack == AT_INTRO && state == PS_ATTACK_GROUND && gen_image_index < 14.5) {
        shader_start();
        draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, 1);
        shader_end();
    }
}