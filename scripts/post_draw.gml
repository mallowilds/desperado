// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character

init_shader();


// Skull rendering
if (head.state == 0) {
	
	var _s = null;
	
	for (var i = 0; i < array_length(anim_list); i++) {
		if (sprite_index == sprite_get(anim_list[i])) {
			_s = anim_list[i];
		}
	}
	
	if (_s != null) {
	    _s = _s + "_skull";
	    
	    shader_start();
    	draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 1);
        shader_end();
	    
	    if (perfect_dodging) { // Parry recolor
	        gpu_set_fog(true, make_color_rgb(165, 155, 205), 0, 1);
	        draw_sprite_ext(sprite_get(_s), image_index, x, y, spr_dir, 1, 0, c_white, 1);
	        gpu_set_fog(false, c_white, 0, 1);
	        
	        for (var i = 0; i <= 7; i++) set_article_color_slot(i, 0, 0, 0, 0); // Outlines need to be redrawn manually
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
	    
	}
	
}




// Flames (based on aur sparkles. managed in update.gml, added in update.gml)
shader_start();

for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
}

shader_end();