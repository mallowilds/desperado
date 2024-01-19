// update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Code here is run every frame for your character.

if (get_gameplay_time() == 4 && !is_seasonal) {
	set_attack(AT_INTRO);
	if (is_genesis) {
		with oPlayer if (self != other) other.genesis_spawn_player_id = self;
		set_attack_value(AT_INTRO, AG_SPRITE, sprite_get("intro_gen"));
	}
}

//#region SFX things
if state == PS_CROUCH && state_timer == 1 && !hitpause {
    //sound_stop(wavedashsfx)
    //sound_play(wavedashsfx, 0, noone, 1, 1.3)

}
if state == PS_AIR_DODGE && state_timer == 0 && !hitpause {
    sound_play(adodge)
}
if state == PS_WAVELAND && state_timer == 0 && !hitpause {
    sound_stop(adodge)
    sound_play(asset_get("sfx_waveland_zet"), 0, noone, 0.4, 0.97)
    sound_play(wavedashsfx, 0, noone, 1, 1.3)

}
if state == PS_LANDING_LAG && (attack == AT_BAIR || attack == AT_EXTRA_1) {
    sound_stop(bair_sfx_instance);
    bair_sfx_instance = noone;
}
//#endregion


//#region Anti-stall check management
// Be sure to also reset these in death.gml and got_hit.gml as needed!

if (!free) move_cooldown[AT_DSPECIAL] = 0;
if (!free || state == PS_WALL_JUMP) move_cooldown[AT_NSPECIAL] = 0; // also gets reset by dspecial for Shenanigans

//#endregion


//#region HUD management

// Nametag
if (nametag_white_flash > 0) nametag_white_flash -= 0.1;
if (num_bullets >= 4 && nametag_flame_alpha < 1) nametag_flame_alpha += 0.2;
else if (num_bullets < 4 && nametag_flame_alpha > 0) nametag_flame_alpha -= 0.2;


// Async reload anim
if (reload_anim_timer < 8) reload_anim_timer++;

//#endregion


//#region HUD reload anim management
switch reload_anim_state {
    case 0: // Idle
        reload_anim_frame = 0;
        break;
    case 1: // Loop startup
        reload_anim_frame = 1 + (reload_anim_timer / 2);
        if (reload_anim_frame >= 3) {
            reload_anim_state = 2;
            reload_anim_timer = 0;
        }
        break;
    case 2: // Loop
        reload_anim_frame = 3+(reload_anim_timer/3)%2;
        break;
    case 3: // Click up
        reload_anim_frame = 5 + floor(reload_anim_timer/3);
        if (reload_anim_frame >= 10) {
            reload_anim_state = 0;
            reload_anim_timer = 0;
            reload_anim_frame = 0;
        }
        break;
    case 4: // Click in (fire)
        reload_anim_frame = 10 + (reload_anim_timer / 2)
        if (reload_anim_frame >= 14) {
            reload_anim_state = 0;
            reload_anim_timer = 0;
            reload_anim_frame = 0;
        }
        break;
        
}
reload_anim_timer++;
//#endregion


//#region Sparkle management (Added by update.gml, hitbox_update.gml, and article1_update.gml, drawn in post_draw and article1_pre_draw)
for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    sp.sp_lifetime++;
    if (sp.sp_lifetime >= sp.sp_max_lifetime) {
        ds_list_remove(sparkle_list, sp);
        i--;
    }
}

if (num_bullets >= 4 && get_gameplay_time() % 7 == 0) {
	if (is_genesis) spawn_sparkle_genesis(get_gameplay_time()%17, get_gameplay_time()%37);
	else spawn_sparkle(get_gameplay_time()%17, get_gameplay_time()%37);
}
//#endregion


//#region NSpec gunshot management (drawn in pre_draw.gml, added by attack_update.gml)
if (!hitpause || state == PS_HITSTUN) { // Should still advance on enemy hitpause, just not on Desperado's
    for (var i = 0; i < ds_list_size(nspec_shot_list); i++) {
        var sp = ds_list_find_value(nspec_shot_list, i);
        sp.sp_lifetime++;
        if (sp.sp_lifetime >= sp.sp_shot_lifetime + sp.sp_smoke_time_offset + sp.sp_smoke_lifetime) {
            ds_list_remove(nspec_shot_list, sp);
            i--;
        }
    }
}
//#endregion


//#region Reset fractional damage on enemy death
with object_index {
    if (!clone && (state == PS_DEAD || state == PS_RESPAWN)) {
        u_mult_damage_buffer = 0;
    }
}
//#endregion


//#region Skull article management

if (head_obj.state != 0 && char_height > 50) char_height -= 2;
else if (head_obj.state == 0 && char_height < 70) char_height++;

// Lock out commands if head is in a busy state (technically redundant but improves responsiveness)
if (!head_obj.can_fspecial) {
    move_cooldown[AT_FSPECIAL_2] = 2;
}

// Script order reliant.
draw_skull_grabbox = clamp(draw_skull_grabbox-1, 0, draw_skull_grabbox)


if (!instance_exists(head_obj)) {
    head_obj = instance_create(x, y, "obj_article1");
    print_debug("------------------------------------------------------------------------------------");
    print_debug("Spawning new skull. If this occurs, something has gone wrong.");
    print_debug("Please ensure that opposing characters aren't improperly destroying enemy articles.");
    print_debug("------------------------------------------------------------------------------------");
}

//#endregion

// One more failsafe for good measure
if (num_bullets > 6 || num_bullets < 0) {
    print_debug("ERROR: bad bullet count (" + string(num_bullets) + "). Resetting.");
    num_bullets = clamp(num_bullets, 0, 6);
}



//#region Skull-less-ness management
if (head_obj.state != 0) {
	
	if (hurtboxID.sprite_index == sprite_get("desp_hurt")) {
	    hurtboxID.sprite_index = sprite_get("desp_hurt_skulless");
	    hurtboxID.mask_index = sprite_get("desp_hurt_skulless");
	}
	
	else if (state == PS_HITSTUN || state == PS_HITSTUN_LAND) {
        hurtboxID.sprite_index = sprite_get("desp_hitstun_hurt_skulless");
    	hurtboxID.mask_index = sprite_get("desp_hitstun_hurt_skulless");
    }
	
	else {
	    var _s = null;
    	
    	for (var i = 0; i < array_length(anim_list); i++) {
    		if (hurtboxID.sprite_index == sprite_get(anim_list[i]+"_hurt")) {
    			_s = anim_list[i];
    		}
    	}
    	
    	if (_s != null) {
    	    _s = _s + "_skulless_hurt";
    	    hurtboxID.sprite_index = sprite_get(_s);
    	    hurtboxID.mask_index = sprite_get("_s");
    	}
    	
	}
}
else if (hurtboxID.sprite_index == sprite_get("desp_hurt_skulless") || hurtboxID.sprite_index == sprite_get("desp_hitstun_hurt_skulless")) {
    hurtboxID.sprite_index = sprite_get("desp_hurt"); // game will autocorrect from here as needed
	hurtboxID.mask_index = sprite_get("desp_hurt");
}
else if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) { // Note: desp doesn't use air hurts, so they can be safely ignored here
	hurtboxID.sprite_index = get_attack_value(attack, AG_HURTBOX_SPRITE);
	hurtboxID.mask_index = get_attack_value(attack, AG_HURTBOX_SPRITE);
}

//#endregion

//#region Seasonal management
if (display_seasonal && state != PS_IDLE && state != PS_SPAWN && state != PS_RESPAWN) {
	display_seasonal = false;
	if (vfx_seasonal[seasonal_type] != noone) {
		var season_despawn = spawn_hit_fx(x, y, vfx_seasonal[seasonal_type]);
		season_despawn.spr_dir = spr_dir;
		season_despawn.depth = depth-1;
	}
}
//#endregion

//#region Genesis Alt Hueshift (this is a template)
	
	
    hue_offset = hue_offset + (1*hue_increasing)
    if hue_offset > 255 {
    	hue_increasing = -1
    }
    if hue_offset < 200 {
    	hue_increasing = 1
    }
	
    color_rgb=make_color_rgb(  176, 18, 8 ); //input rgb values here, uses rgb to create a gamemaker colour variable
    
    value = (color_get_value(color_rgb)+hue_offset) mod 255; //finds the hue and shifts it
    
    color_hsv = make_color_hsv(color_get_hue(color_rgb),color_get_saturation(color_rgb),value); //creates a new gamemaker colour variable using the shifted hue
    
    set_color_profile_slot( 13, 1, color_get_red(color_hsv),color_get_green(color_hsv),color_get_blue(color_hsv)); //uses that variable to set the slot's new colours
    set_color_profile_slot( 13, 3, color_get_red(color_hsv),color_get_green(color_hsv),color_get_blue(color_hsv)); //uses that variable to set the slot's new colours
//#endregion

#define set_head_state(new_state)
    head_obj.state = new_state;
    head_obj.state_timer = 0;
    head_obj.window = 1;
    head_obj.window_timer = 1;
    return;

#define spawn_sparkle(seed1, seed2)
    var sparkle_type = random_func_2(seed1, 3, true);
    if (sparkle_type == 0) spawn_particle_random("fire1", 10, seed2, spr_dir);
    else if (sparkle_type == 1) spawn_particle_random("fire2", 15, seed2, spr_dir);
    else if (sparkle_type == 2) spawn_particle_random("fire3", 15, seed2, spr_dir);
   
#define spawn_sparkle_genesis(seed1, seed2)
    var sparkle_type = random_func_2(seed1, 4, true)+1;
    spawn_particle_random("fire"+string(sparkle_type)+"_gen", 10, seed2, 1);
    
#define spawn_particle_random(in_sprite, lifetime, seed, in_spr_dir)
    var min_rad = 34;
    var rad_range = 14;
    var y_offset = -40;
    var _rot = random_func_2(seed, 240, false) - 60;
    var _dist = min_rad + random_func_2(seed+1, rad_range, false);
    var _x = x + lengthdir_x(_dist, _rot);
    var _y = y + lengthdir_y(_dist, _rot) + y_offset;
    var sparkle = {
        sp_x : _x,
        sp_y : _y,
        sp_sprite_index : sprite_get(in_sprite),
        sp_max_lifetime : lifetime,
        sp_lifetime : 0,
        sp_spr_dir : in_spr_dir,
        sp_skull_owned : 0,
    };
    ds_list_add(sparkle_list, sparkle);