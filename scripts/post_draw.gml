// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character


shader_start();

// Flames (based on aur sparkles. managed in update.gml, added in update.gml)
for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
}

shader_end();