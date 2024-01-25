// other_pre_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#other-pre-draw-gml-and-other-post-draw-gml
// Draws BEHIND all OTHER characters


// Genesis alt
if ("is_genesis" not in other_player_id) exit;
with other_player_id {
    if (is_genesis && other == genesis_spawn_player_id && attack == AT_INTRO && state == PS_ATTACK_GROUND && gen_image_index < 14.5) {
        createMask(sprite_get("staticimg"));
    }
}

#define maskHeader()
// Mask renderer utility: disables Normal draw.
// Draw shapes or sprites to be used as the stencil(s) by maskMidder.
//================================================================================
{
    gpu_set_blendenable(false);
    gpu_set_colorwriteenable(false,false,false,true);
    
}
//================================================================================
#define maskMidder()
// Reenables draw but only within the region drawn between maskHeader and maskMidder.
// Lasts until maskFooter is called.
//================================================================================
{
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true,true,true,true);
    gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
    gpu_set_alphatestenable(true);
}
//================================================================================
#define maskFooter()
// Restores normal drawing parameters//================================================================================
{
    gpu_set_alphatestenable(false);
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}
//================================================================================
#define createMask(the_image) // heavily modified
// creates the masking//================================================================================
{
    maskHeader();
    maskMidder();
    maskFooter();
    shader_start();
    draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, 1);
    shader_end();
    maskHeader();
    draw_set_alpha(0);
    draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, c_white, c_white, 0);
    draw_set_alpha(1);
    draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, .3);
    maskMidder();
    shader_start();
    draw_sprite_tiled_ext(the_image, 0, 0, 0, .5, .5, c_white, 1);
    shader_end();
    maskFooter();
}