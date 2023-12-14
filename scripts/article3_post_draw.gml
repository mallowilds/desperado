

// Bullet casing
switch state {
    
    case 01:
    case 02:
        with (player_id) shader_start();
        draw_sprite_ext(sprite_get("bullet"), 0, x, y, spr_dir, 1, proj_angle, c_white, 1);
        shader_end();
        break;
    
    case 11:
        draw_sprite_ext(icon_spr, icon_image, x-16, y-78, icon_scale, icon_scale, 0, c_white, 1);
        if (get_match_setting(SET_HITBOX_VIS)) draw_sprite_ext(sprite_get("sign_mask"), 0, x, y, 1, 1, 0, c_white, 0.5);
        break;
        
    case 12:
        draw_sprite_ext(icon_spr, icon_image, x-16-(2*spr_dir*(2-floor(image_index))*(image_index<2)), y-78, icon_scale, icon_scale, 0, c_white, 1);
        if (get_match_setting(SET_HITBOX_VIS)) draw_sprite_ext(sprite_get("sign_mask"), 0, x, y, 1, 1, 0, c_white, 0.5);
        break;
        
    case 13:
        draw_sprite_ext(icon_spr, icon_image, x-16+(2*spr_dir*(2-floor(image_index))*(image_index<2)), y-78, icon_scale, icon_scale, 0, c_white, 1);
        if (get_match_setting(SET_HITBOX_VIS)) draw_sprite_ext(sprite_get("sign_mask"), 0, x, y, 1, 1, 0, c_white, 0.5);
        break;
    
    case 14:
        if (image_index < 1) draw_sprite_ext(icon_spr, icon_image, x-16, y-78, icon_scale, icon_scale, 0, c_white, 1);
        break;
    
    case 15:
        if (image_index < 10) draw_sprite_ext(icon_spr, icon_image, x-16, y-78, icon_scale, icon_scale, 0, c_white, 1);
        with (player_id) shader_start();
        draw_sprite(sprite_get("sign_burn_top"), image_index, x, y);
        shader_end();
        break;
    
    case 21:
        with (player_id) shader_start();
        draw_sprite_ext(sprite_get("taunt_shot"), 0, x, y, 1, 1, move_angle, c_white, 1);
        if (screen_wrap && spr_dir == -1 && x+hsp < view_get_xview()) draw_sprite_ext(sprite_get("taunt_shot"), 0, x+view_get_wview(), y, 1, 1, move_angle, c_white, 1); // WARN: Possible Desync. Consider using get_instance_x(asset_get("camera_obj")).
        else if (screen_wrap && spr_dir == 1 && x+hsp > view_get_xview()+view_get_wview()) draw_sprite_ext(sprite_get("taunt_shot"), 0, x-view_get_wview(), y, 1, 1, move_angle, c_white, 1); // WARN: Possible Desync. Consider using get_instance_x(asset_get("camera_obj")).
        shader_end();
        break;
    
}