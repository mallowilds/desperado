// hitbox_init.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/hitbox_scripts.html#hitbox-init-gml
// Called when your character creates a hitbox, from the hitbox's perspective.


// DSpecial spare-bullet visual
if (attack == AT_DSPECIAL && hit_priority == 0) {
    vis_bounces = 0;
}