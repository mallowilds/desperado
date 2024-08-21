// articleX_post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#article-draw
// Draws BEHIND the article
// This script can be created for any article index (1, 2, 3, solid, and platform)


// Ash particle management (built off of sparkle system; see update.gml)
for (var i = 0; i < ds_list_size(player_id.sparkle_list); i++) {
    var sp = ds_list_find_value(player_id.sparkle_list, i);
    if (sp.sp_skull_owned) {
    	var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    	draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
    }
}


// NSpec shot management
if (state == AT_NSPECIAL) {
    
    if (window == 2 || window == 3) {
        
        shader_end();
        
        var _x = x;
        var _y = y-30;
        
        var _col1 = make_color_rgb(get_color_profile_slot_r(get_player_color(player), 5), get_color_profile_slot_g(get_player_color(player), 5), get_color_profile_slot_b(get_player_color(player), 5));
        var _col2 = make_color_rgb(get_color_profile_slot_r(get_player_color(player), 8), get_color_profile_slot_g(get_player_color(player), 8), get_color_profile_slot_b(get_player_color(player), 8));
        
        draw_set_alpha(reticle_alpha);
        draw_line_width_color(_x, _y, _x+lengthdir_x(1000, reticle_angle+reticle_offset_angle), _y+lengthdir_y(1000, reticle_angle+reticle_offset_angle), 2, _col1, _col2);
        draw_line_width_color(_x, _y, _x+lengthdir_x(1000, reticle_angle-reticle_offset_angle), _y+lengthdir_y(1000, reticle_angle-reticle_offset_angle), 2, _col1, _col2);
        
        draw_set_alpha(reticle_flash);
        draw_line_width_color(_x+1, _y+1, _x+1+lengthdir_x(1000, reticle_angle+reticle_offset_angle), _y+1+lengthdir_y(1000, reticle_angle+reticle_offset_angle), 2, c_ltgray, c_ltgray);
        draw_line_width_color(_x+1, _y+1, _x+1+lengthdir_x(1000, reticle_angle-reticle_offset_angle), _y+1+lengthdir_y(1000, reticle_angle-reticle_offset_angle), 2, c_ltgray, c_ltgray);
        draw_line_width_color(_x, _y, _x+lengthdir_x(1000, reticle_angle+reticle_offset_angle), _y+lengthdir_y(1000, reticle_angle+reticle_offset_angle), 2, c_white, c_white);
        draw_line_width_color(_x, _y, _x+lengthdir_x(1000, reticle_angle-reticle_offset_angle), _y+lengthdir_y(1000, reticle_angle-reticle_offset_angle), 2, c_white, c_white);
        
        draw_set_alpha(1);
        
        with (player_id) shader_start();
        
    }
    
}

if (shot_visual != noone) {
    
    // Draw smoke
    var length_remaining = shot_visual.sp_length;
    var cur_x = shot_visual.sp_x;
    var cur_y = shot_visual.sp_y;
    var smoke_start_time = shot_visual.sp_smoke_time_offset + shot_visual.sp_shot_lifetime
    var smoke_image_index = (shot_visual.sp_lifetime-smoke_start_time) * (sprite_get_number(shot_visual.sp_smoke_index) / shot_visual.sp_smoke_lifetime);
    
    if (shot_visual.sp_lifetime >= smoke_start_time) {
        while (sprite_get_width(shot_visual.sp_smoke_index) < length_remaining) {
            draw_sprite_ext(shot_visual.sp_smoke_index, smoke_image_index, cur_x, cur_y, 1, 1, shot_visual.sp_angle, c_white, 1);
            length_remaining -= sprite_get_width(shot_visual.sp_smoke_index);
            cur_x += lengthdir_x(sprite_get_width(shot_visual.sp_smoke_index), shot_visual.sp_angle);
            cur_y += lengthdir_y(sprite_get_width(shot_visual.sp_smoke_index), shot_visual.sp_angle);
        }
        var part_x_adj = lengthdir_x(sprite_get_xoffset(shot_visual.sp_smoke_index), shot_visual.sp_angle) + lengthdir_x(sprite_get_yoffset(shot_visual.sp_smoke_index), shot_visual.sp_angle+90);
        var part_y_adj = lengthdir_y(sprite_get_xoffset(shot_visual.sp_smoke_index), shot_visual.sp_angle) + lengthdir_y(sprite_get_yoffset(shot_visual.sp_smoke_index), shot_visual.sp_angle+90);
        draw_sprite_general(shot_visual.sp_smoke_index, smoke_image_index, 0, 0, length_remaining, sprite_get_height(shot_visual.sp_smoke_index), cur_x+part_x_adj, cur_y+part_y_adj, 1, 1, shot_visual.sp_angle, c_white, c_white, c_white, c_white, 1);
    }
    
    // Draw blast
    var length_remaining = shot_visual.sp_length;
    var cur_x = shot_visual.sp_x;
    var cur_y = shot_visual.sp_y;
    var shot_image_index = shot_visual.sp_lifetime * (sprite_get_number(shot_visual.sp_tile_index) / shot_visual.sp_shot_lifetime);
    
    if (shot_visual.sp_lifetime < shot_visual.sp_shot_lifetime) {
        draw_sprite_ext(shot_visual.sp_start_index, shot_image_index, cur_x, cur_y, 1, 1, shot_visual.sp_angle, c_white, 1);
        length_remaining -= sprite_get_width(shot_visual.sp_start_index);
        cur_x += lengthdir_x(sprite_get_width(shot_visual.sp_start_index), shot_visual.sp_angle);
        cur_y += lengthdir_y(sprite_get_width(shot_visual.sp_start_index), shot_visual.sp_angle);
        
        while (sprite_get_width(shot_visual.sp_tile_index)+shot_visual.sp_edge_width < length_remaining) {
            draw_sprite_ext(shot_visual.sp_tile_index, shot_image_index, cur_x, cur_y, 1, 1, shot_visual.sp_angle, c_white, 1);
            length_remaining -= sprite_get_width(shot_visual.sp_tile_index);
            cur_x += lengthdir_x(sprite_get_width(shot_visual.sp_tile_index), shot_visual.sp_angle);
            cur_y += lengthdir_y(sprite_get_width(shot_visual.sp_tile_index), shot_visual.sp_angle);
        }
        
        var part_x_adj = lengthdir_x(sprite_get_xoffset(shot_visual.sp_tile_index), shot_visual.sp_angle) + lengthdir_x(sprite_get_yoffset(shot_visual.sp_tile_index), shot_visual.sp_angle+90);
        var part_y_adj = lengthdir_y(sprite_get_xoffset(shot_visual.sp_tile_index), shot_visual.sp_angle) + lengthdir_y(sprite_get_yoffset(shot_visual.sp_tile_index), shot_visual.sp_angle+90);
        draw_sprite_general(shot_visual.sp_tile_index, shot_image_index, 0, 0, length_remaining-shot_visual.sp_edge_width, sprite_get_height(shot_visual.sp_tile_index), cur_x+part_x_adj, cur_y+part_y_adj, 1, 1, shot_visual.sp_angle, c_white, c_white, c_white, c_white, 1);
        
        cur_x += lengthdir_x(length_remaining-shot_visual.sp_edge_width, shot_visual.sp_angle);
        cur_y += lengthdir_y(length_remaining-shot_visual.sp_edge_width, shot_visual.sp_angle);
        draw_sprite_ext(shot_visual.sp_edge_index, shot_image_index, cur_x, cur_y, 1, 1, shot_visual.sp_angle, c_white, 1);
        
    }
    
}