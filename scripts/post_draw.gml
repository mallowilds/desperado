// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character


shader_start();

// Skull rendering
if (head.state == 0) {
	
	var _s = null;
	var _image_index = image_index;
	
	for (var i = 0; i < array_length(anim_list); i++) {
		if (sprite_index == sprite_get(anim_list[i])) {
			sprite_index = sprite_get(anim_list[i]+"_detached");
			_s = anim_list[i];
		}
	}
	
	if (_s != null) {
	    _s = _s + "_skull";
	    draw_sprite_ext(sprite_get(_s), _image_index, x, y, spr_dir, 1, 0, c_white, 1);
	    print_debug(image_index);
	}
	
}


// Flames (based on aur sparkles. managed in update.gml, added in update.gml)
for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_sprite_index) / sp.sp_max_lifetime);
    draw_sprite_ext(sp.sp_sprite_index, sp_image_index, sp.sp_x, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1 );
}

shader_end();