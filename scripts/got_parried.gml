// got_parried.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-parried-gml
// Called when one of your hitboxes is parried.


// Spawn wasted bullet visual + deduct 2 bullets
if (num_bullets >= 2) {
    var hbox = create_hitbox(AT_DSPECIAL, 1, x, y-10);
    hbox.vsp = -5
}
if (num_bullets >= 1) {
    var hbox = create_hitbox(AT_DSPECIAL, 1, x, y-10);
    hbox.hsp = -3*spr_dir;
}
num_bullets = clamp(num_bullets-2, 0, 6);