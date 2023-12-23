// got_parried.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-parried-gml
// Called when one of your hitboxes is parried.


// Handling for parried/reflected stuff
if (my_hitboxID.orig_player == player && my_hitboxID.player != player) exit;


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


// On parried fspec: kill head
if (my_hitboxID.attack == AT_FSPECIAL) {
    with head_obj {
        state = 4;
        state_timer = 0;
        respawn_penalty = true;
    }
}

else if (my_hitboxID.attack == AT_FSPECIAL_2) {
    with head_obj {
        // it's dying anyway, but also...
        respawn_give_bullet = false;
    }
}