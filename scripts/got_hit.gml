// got_hit.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-hit-gml
// Called when you get hit



// Reset anti-stall checks
dairs_used = 0;
move_cooldown[AT_DSPECIAL] = 0;
move_cooldown[AT_USPECIAL] = 0;


// SFX checks
if ((prev_state == PS_ATTACK_AIR || prev_state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL) {
    sound_stop(sound_get("desp_whisper"));
}


if (prev_state == PS_ATTACK_GROUND && attack == AT_FSTRONG_2) {
    sound_stop(sound_get("desp_spin"));
    if (window <= 2) {
        num_bullets--;
        var bullet_casing = instance_create(x, y-10, "obj_article3");
        bullet_casing.state = 00;
        bullet_casing.hsp = -3*spr_dir;
        bullet_casing.vsp = -6;
    }
}