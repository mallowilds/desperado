// hitbox_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/hitbox_scripts.html#hitbox-update-gml
// Called every frame for each of your character's hitboxes, from the hitbox's perspective.

if (attack == AT_FSPECIAL_2) {
    
    switch hbox_num {
        
        case 1:
            if (hitbox_timer == 3) {
                child_hitbox = create_hitbox(AT_FSPECIAL_2, 2, x, y);
                child_hitbox.parent_hitbox = self;
            }
        
        
    }
    
}