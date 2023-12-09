// hitbox_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/hitbox_scripts.html#hitbox-update-gml
// Called every frame for each of your character's hitboxes, from the hitbox's perspective.

if (attack == AT_FSPECIAL_2) {
    
    switch hbox_num {
        
        case 1:
            if (hitbox_timer == 1) sound_play(asset_get("sfx_mol_norm_explode"));
            if (hitbox_timer == 3 && hitstop_timer <= 0) {
                child_hitbox = create_hitbox(AT_FSPECIAL_2, 2, x, y);
                child_hitbox.parent_hitbox = self;
            }
        
        case 2:
            hitstop_timer = clamp(hitstop_timer-1, 0, 20);
            in_hitpause = (hitstop_timer > 0)
            break;
        
    }
    
}