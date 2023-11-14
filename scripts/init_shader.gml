// init_shader.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#initializing-graphics

// Reset article color slots
for (var i = 0; i <= 7; i++) set_article_color_slot(i, get_color_profile_slot_r(get_player_color(player), i), get_color_profile_slot_g(get_player_color(player), i), get_color_profile_slot_b(get_player_color(player), i), 1);


switch get_player_color(player) {
    
    case 0:
        set_character_color_slot( 1, 221, 157, 136);
        set_article_color_slot( 1, 221, 157, 136);
        break;
    
    case 9:
        set_character_color_shading(1, -2);
        set_character_color_shading(2,  2);
        break;
    
    case 7:
        set_character_color_shading(0, 0);
        set_character_color_shading(1, 0);
        set_character_color_shading(2, 0);
        set_character_color_shading(3, 0);
        set_character_color_shading(4, 0);
        set_character_color_shading(5, 0);
        set_character_color_shading(6, 0);
        set_character_color_shading(7, 0);
        outline_color = [42, 90, 63]; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        break;
    
    case 13:
        outline_color = [50, 0, 0]; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        break;
    
    case 14:
        set_character_color_slot( 2, 8, 117, 75, 0.5);
        set_article_color_slot( 2, 221, 157, 136);
        break;
    
}