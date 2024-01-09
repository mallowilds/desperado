// other_pre_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#other-pre-draw-gml-and-other-post-draw-gml
// Draws BEHIND all OTHER characters


// Genesis alt
with other_player_id {
    if (is_genesis && other.player == genesis_spawn_player && attack == AT_INTRO && state == PS_ATTACK_GROUND && gen_image_index < 14) {
        shader_start();
        draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, 1);
        shader_end();
    }
}
