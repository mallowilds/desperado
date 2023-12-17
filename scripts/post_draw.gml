// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character

init_shader();


// Overhead HUD
if ((get_local_setting(SET_HUD_SIZE) != 0 || get_local_setting(SET_HUD_NAMES) != 0)) {
	
	shader_start();
	
	if (num_bullets > 0) draw_sprite(sprite_get("nametag_bullets"), num_bullets, x+8, y-char_height-40);
	
	draw_set_alpha(nametag_flame_alpha);
	draw_sprite(sprite_get("nametag_fire"), get_gameplay_time()/5, x+8, y-char_height-40);
	
	shader_end();
	
	if (nametag_white_flash > 0) {
		draw_set_alpha(nametag_white_flash);
		gpu_set_fog(true, c_white, 0, 1);
		draw_sprite(sprite_get("nametag_bullets"), num_bullets, x+8, y-char_height-40);
		if (num_bullets >= 4) draw_sprite(sprite_get("nametag_fire"), get_gameplay_time()/5, x+8, y-char_height-40);
		gpu_set_fog(false, c_white, 0, 1);
	}
	
	draw_set_alpha(1);
}



// Sparkle management (manages flame and ash particles. See update.gml)
// Note: due to flame coloration, this tampers with color slot 0
set_article_color_slot(0, color_get_red(get_color_profile_slot_r(get_player_color(player), 8)), color_get_green(get_color_profile_slot_g(get_player_color(player), 8)), color_get_blue(get_color_profile_slot_b(get_player_color(player), 8)));
shader_start();

for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    if (!sp.sp_skull_owned) {
    	var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    	draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
    }
}

shader_end();
init_shader();