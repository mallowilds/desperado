// hitbox_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/hitbox_scripts.html#hitbox-update-gml
// Called every frame for each of your character's hitboxes, from the hitbox's perspective.

if (attack == AT_FSPECIAL_2) {
    
    switch hbox_num {
        
        case 1:
            if (hitbox_timer == 1) {
                sound_play(asset_get("sfx_mol_norm_explode"));
            }
            if (hitbox_timer == 2 && hitstop_timer <= 0) {
                child_hitbox = create_hitbox(AT_FSPECIAL_2, 2, x, y);
                child_hitbox.parent_hitbox = self;
            }
            if (image_index >= 2 && image_index <= 4 && hitstop_timer <= 0) {
                spawn_particle_random("ashpart_1", 18, 6*player);
                spawn_particle_random("ashpart_1", 18, 6*player+2);
            }
        
        case 2:
            hitstop_timer = clamp(hitstop_timer-1, 0, 20);
            in_hitpause = (hitstop_timer > 0)
            break;
        
    }
    
}



#define spawn_particle_random(in_sprite, lifetime, seed)
    var min_rad = 24;
    var rad_range = 26;
    var y_offset = 0;
    var _rot = random_func_2(seed, 360, false);
    var _dist = min_rad + random_func_2(seed+1, rad_range, false);
    var _x = x + lengthdir_x(_dist, _rot);
    var _y = y + lengthdir_y(_dist, _rot) + y_offset;
    var sparkle = {
        sp_x : _x,
        sp_y : _y,
        sp_sprite_index : sprite_get(in_sprite),
        sp_max_lifetime : lifetime,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir
    };
    ds_list_add(player_id.sparkle_list, sparkle);