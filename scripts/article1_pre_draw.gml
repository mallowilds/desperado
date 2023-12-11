// articleX_post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#article-draw
// Draws BEHIND the article
// This script can be created for any article index (1, 2, 3, solid, and platform)



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