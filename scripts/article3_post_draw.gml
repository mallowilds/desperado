

// Bullet casing
switch state {
    
    case 01:
    case 02:
        draw_sprite_ext(sprite_get("bullet"), 0, x, y, spr_dir, 1, proj_angle, c_white, 1);
        break;
    
    case 11:
    case 12:
    case 13:
        draw_sprite_ext(icon_spr, icon_image, x-16, y-78, icon_scale, icon_scale, 0, c_white, 1);
        //draw_sprite_ext(mask_index, 0, x, y, 1, 1, 0, c_white, 0.5);
        break;
    
    
    
}