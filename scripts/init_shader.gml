// init_shader.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#initializing-graphics

// Online CSS safety check (courtesy of https://rivalswsmanual.miraheze.org/wiki/Init_shader.gml)
var real_player = (room == asset_get("network_char_select") && object_index != oTestPlayer) ? 0 : player;
var alt_palette = get_player_color( real_player );

// Reset article color slots
for (var i = 0; i <= 7; i++) set_article_color_slot(i, get_color_profile_slot_r(alt_palette, i), get_color_profile_slot_g(alt_palette, i), get_color_profile_slot_b(alt_palette, i), 1);


switch alt_palette {
    
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
    case 15:
        set_character_color_shading(0, 3);
        set_character_color_shading(1, 3);
    
}



switch (get_match_setting(SET_SEASON)) {
  case 1: // valentines
    // Forevermore
    set_color_profile_slot( 12, 0, 255, 143, 219 ); //Bones
    set_color_profile_slot( 12, 1, 255, 158, 187 ); //Horns
    set_color_profile_slot( 12, 2, 143, 86, 131 ); //Smog
    set_color_profile_slot( 12, 3, 255, 201, 218 ); //Ash
    set_color_profile_slot( 12, 4, 196, 77, 147 ); //Coat
    set_color_profile_slot( 12, 5, 246, 77, 213 ); //Fire
    set_color_profile_slot( 12, 6, 255, 175, 254 ); //Fireyellow
    set_color_profile_slot( 12, 7, 148, 84, 134 ); //Gun
    set_color_profile_slot( 12, 8, 246, 77, 213 ); //Firedark
    break;
  case 2: // summer
    // Mr. 101
    set_color_profile_slot( 12, 0, 186, 181, 173 ); //Bones
    set_color_profile_slot( 12, 1, 237, 116, 95 ); //Horns
    set_color_profile_slot( 12, 2, 140, 95, 36 ); //Smog
    set_color_profile_slot( 12, 3, 166, 27, 0 ); //Ash
    set_color_profile_slot( 12, 4, 235, 101, 12 ); //Coat
    set_color_profile_slot( 12, 5, 204, 34, 0 ); //Fire
    set_color_profile_slot( 12, 6, 255, 102, 0 ); //Fireyellow
    set_color_profile_slot( 12, 7, 235, 101, 12 ); //Gun
    set_color_profile_slot( 12, 8, 166, 27, 0 ); //Firedark
    break;
  case 3: // halloween   
    // Dullahan
    set_color_profile_slot( 12, 0, 255, 96, 0 ); //Bones
    set_color_profile_slot( 12, 1, 255, 96, 0 ); //Horns
    set_color_profile_slot( 12, 2, 10, 7, 7 ); //Smog
    set_color_profile_slot( 12, 3, 9, 74, 0 ); //Ash
    set_color_profile_slot( 12, 4, 27, 37, 59 ); //Coat
    set_color_profile_slot( 12, 5, 166, 27, 0 ); //Fire
    set_color_profile_slot( 12, 6, 255, 102, 0 ); //Fireyellow
    set_color_profile_slot( 12, 7, 43, 58, 92 ); //Gun
    set_color_profile_slot( 12, 8, 27, 37, 59 ); //Firedark
    break;
  case 4: // christmas
    // Mr. 10 Below
    set_color_profile_slot( 12, 0, 208, 209, 224 ); //Bones
    set_color_profile_slot( 12, 1, 102, 112, 171 ); //Horns
    set_color_profile_slot( 12, 2, 83, 91, 139 ); //Smog
    set_color_profile_slot( 12, 3, 188, 191, 207 ); //Ash
    set_color_profile_slot( 12, 4, 9, 48, 204 ); //Coat
    set_color_profile_slot( 12, 5, 88, 96, 141 ); //Fire
    set_color_profile_slot( 12, 6, 188, 191, 207 ); //Fireyellow
    set_color_profile_slot( 12, 7, 188, 191, 207 ); //Gun
    set_color_profile_slot( 12, 8, 37, 54, 130 ); //Firedark
    break;
}