// other_post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#other-pre-draw-gml-and-other-post-draw-gml
// Draws in FRONT of all OTHER characters


if ("head_obj" not in other_player_id) exit;
with other_player_id {
    if (head_obj.state == AT_NSPECIAL && instance_exists(head_obj.target_id) && head_obj.target_id == other) {
        if (head_obj.window == 2) draw_sprite(sprite_get("reticle"), (head_obj.window_timer<6?4-(head_obj.window_timer/2):1), other.x-86, other.y-112-(other.char_height*2/3));
        else if (head_obj.window == 3) {
            draw_sprite(sprite_get("reticle"), 1, other.x-86, other.y-112-(other.char_height*2/3));
            
            draw_set_alpha(head_obj.reticle_flash);
            gpu_set_fog(true, c_white, 0, 1);
            draw_sprite(sprite_get("reticle"), 1, other.x-86, other.y-112-(other.char_height*2/3));
            gpu_set_fog(false, c_white, 0, 1);
            draw_set_alpha(1);
        }
    }
}
