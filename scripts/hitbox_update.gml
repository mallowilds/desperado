// hitbox_update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/hitbox_scripts.html#hitbox-update-gml
// Called every frame for each of your character's hitboxes, from the hitbox's perspective.


// DSpecial spare-bullet visual
if (attack == AT_DSPECIAL && hit_priority == 0) {
    
    proj_angle += 5*spr_dir;
    
    if (!free && vis_bounces == 0) {
        
        vsp = -3;
        vis_bounces++;
        grounds = 1;
        walls = 1;
        
    }
}