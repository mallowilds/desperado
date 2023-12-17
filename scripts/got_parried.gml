// got_parried.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-parried-gml
// Called when one of your hitboxes is parried.


// Handling for parried/reflected stuff
if (my_hitboxID.orig_player == player && my_hitboxID.player != player) {
    
    if (attack == AT_FSPECIAL || attack == AT_FSPECIAL_2) {
        // Force parried state
        with my_hitboxID.head_obj.bashed_id {
            was_parried = true;
            set_state(free ? PS_PRATFALL : PS_PRATLAND);
        }
    }
    
    exit;
    
}



// Spawn wasted bullet visual + deduct 2 bullets
if (num_bullets >= 2) {
    var bullet_casing = instance_create(x, y-10, "obj_article3");
    bullet_casing.state = 00;
    bullet_casing.hsp = -3*spr_dir;
    bullet_casing.vsp = -5;
}
if (num_bullets >= 1) {
    var bullet_casing = instance_create(x, y-10, "obj_article3");
    bullet_casing.state = 00;
    bullet_casing.hsp = -2*spr_dir;
    bullet_casing.vsp = -7;
    
    nametag_white_flash = 1;
}
num_bullets = clamp(num_bullets-2, 0, 6);