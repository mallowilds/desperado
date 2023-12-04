// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character

init_shader();


// Skull rendering
if (head_obj.state == 0) {
	
	var _s = null;
	
	for (var i = 0; i < array_length(anim_list); i++) {
		if (sprite_index == sprite_get(anim_list[i])) {
			_s = anim_list[i];
		}
	}
	
	if (_s != null) {
	    _s = _s + "_skull";

	    if (!perfect_dodging) { // Default
	    	shader_start();
	    	draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 1);
	        shader_end();
	    }
	    else { // Parry recolor
	        gpu_set_fog(true, make_color_rgb(165, 155, 205), 0, 1);
	        draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 1);
	        gpu_set_fog(false, c_white, 0, 1);
	    }
	    
	    // Outline handling
	    var s_outline_color = make_color_rgb(outline_color[0], outline_color[1], outline_color[2]);
	    if (s_outline_color != c_black || perfect_dodging) {
	    	print_debug(s_outline_color);
	    	for (var i = 0; i <= 7; i++) set_article_color_slot(i, 0, 0, 0, 0); // Transparent-ify
		    shader_start();
		    draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 1);
		    shader_end();
		    init_shader();
	    }
	    
	    
        if (invincible || attack_invince || initial_invince || hurtboxID.dodging) {
            gpu_set_fog(true, c_white, 0, 1);
            draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 0.5);
            gpu_set_fog(false, c_white, 0, 1);
        }
        
        if (state == PS_PRATFALL || state == PS_PRATLAND) {
            draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_black, 0.5);
        }
	    
	}
	
}



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



// Flames (based on aur sparkles. managed in update.gml, added in update.gml)
shader_start();

for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
}

shader_end();