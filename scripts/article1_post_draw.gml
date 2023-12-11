// articleX_post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#article-draw
// Draws IN FRONT OF the article
// This script can be created for any article index (1, 2, 3, solid, and platform)

if (state != 0) {
    
    draw_sprite_ext(hud_arrow, 0, x, y-64, 1, 1, 0, get_player_hud_color(orig_player), 1);
    
    /*
    for (var i = 0; i < max_health; i++) {
        var _width = 8;
        var _x_offset = (_width*i) - (_width*(max_health-1)/2)
        draw_sprite_ext(sprite_get("skull_hud_health"), (i>=health), x+(5*spr_dir)+_x_offset, y-72, 1, 1, 0, get_player_hud_color(player), 1);
    }
    */
    
}

if (state == AT_NSPECIAL) {
    switch window {
        case 2:
        case 3:
            draw_sprite_ext(sprite_get("skullhurt"), 2, x+draw_x, y+draw_y, spr_dir, 1, 0, c_white, 1);
            break;
        case 4:
            draw_sprite_ext(sprite_get("skullhurt"), 2, x+draw_x, y+draw_y, spr_dir, 1, 0, c_white, 1);
            break;
    }
}