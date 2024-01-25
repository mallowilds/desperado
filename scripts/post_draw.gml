// post_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws in FRONT of your character

init_shader();


// Overhead HUD
if ((get_local_setting(SET_HUD_SIZE) != 0 || get_local_setting(SET_HUD_NAMES) != 0)) {
	
	shader_start();
	
	if (num_bullets > 0) draw_sprite(sprite_get("nametag_bullets"+(get_player_color(player)==7?"_ea":"")), num_bullets, x+8, y-char_height-40);
	
	draw_set_alpha(nametag_flame_alpha);
	draw_sprite(sprite_get("nametag_fire"), get_gameplay_time()/5, x+8, y-char_height-40);
	
	shader_end();
	
	if (nametag_white_flash > 0) {
		draw_set_alpha(nametag_white_flash);
		gpu_set_fog(true, (get_player_color(player)==7?/*#*/$9ae2d3:c_white), 0, 1);
		draw_sprite(sprite_get("nametag_bullets"), num_bullets, x+8, y-char_height-40);
		if (num_bullets >= 4) draw_sprite(sprite_get("nametag_fire"), get_gameplay_time()/5, x+8, y-char_height-40);
		gpu_set_fog(false, c_white, 0, 1);
	}
	
	draw_set_alpha(1);
}



// Sparkle management (manages flame and ash particles. See update.gml)
// Note: due to flame coloration, this tampers with color slot 0
set_article_color_slot(0, get_color_profile_slot_r(get_player_color(player), 8), get_color_profile_slot_g(get_player_color(player), 8), get_color_profile_slot_b(get_player_color(player), 8));
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


// Apply gensis mask
if (is_genesis) createMask(sprite_get("staticimg"));


#define maskHeader()
// Mask renderer utility: disables Normal draw.
// Draw shapes or sprites to be used as the stencil(s) by maskMidder.
//================================================================================
{
    gpu_set_blendenable(false);
    gpu_set_colorwriteenable(false,false,false,true);
    
}
//================================================================================
#define maskMidder()
// Reenables draw but only within the region drawn between maskHeader and maskMidder.
// Lasts until maskFooter is called.
//================================================================================
{
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true,true,true,true);
    gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
    gpu_set_alphatestenable(true);
}
//================================================================================
#define maskFooter()
// Restores normal drawing parameters//================================================================================
{
    gpu_set_alphatestenable(false);
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}
//================================================================================
#define createMask(the_image)
// creates the masking//================================================================================
{
    maskHeader();
    maskMidder();
    maskFooter();
    shader_start();
    draw_sprite_ext(sprite_index, image_index, x + draw_x, y + draw_y, spr_dir * (small_sprites + 1), (small_sprites + 1), spr_angle, c_white, 1);
    shader_end();
    maskHeader();
    draw_set_alpha(0);
    draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, c_white, c_white, 0);
    draw_set_alpha(1);
    draw_sprite_ext(sprite_index, image_index, x + draw_x, y + draw_y, spr_dir * (small_sprites + 1), (small_sprites + 1), spr_angle, c_white, .15);
    maskMidder();
    shader_start();
    draw_sprite_tiled_ext(the_image, 0, 0, 0, .5, .5, c_white, 1);
    shader_end();
    maskFooter();
}

    gpu_set_alphatestenable(true);
    
    if("small_sprites" in self) var s = (1 + small_sprites);
    
    if strong_flashing {
        gpu_set_fog(1, c_yellow, 0, 1);
        draw_sprite_ext(sprite_index, image_index, x + draw_x, y + draw_y, s * spr_dir, s, spr_angle, c_yellow, .5);
    }
    
    if invincible || hurtboxID.sprite_index == asset_get("empty_sprite") {
        gpu_set_fog(1, c_white, 0, 1);
        draw_sprite_ext(sprite_index, image_index, x + draw_x, y + draw_y, s * spr_dir, s, spr_angle, c_white, .5);
    }
    
    if state == PS_PRATFALL || state == PS_PRATLAND {
        gpu_set_fog(1, c_black, 0, 1);
        draw_sprite_ext(sprite_index, image_index, x + draw_x, y + draw_y, s * spr_dir, s, spr_angle, c_black, .5);
    }
    
    gpu_set_fog(0, c_white, 0, 0);
    gpu_set_alphatestenable(false);