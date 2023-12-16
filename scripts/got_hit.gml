// got_hit.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-hit-gml
// Called when you get hit


// SFX checks
if ((prev_state == PS_ATTACK_AIR || prev_state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL) {
    sound_stop(sound_get("desp_whisper"));
}


if (prev_state == PS_ATTACK_GROUND && attack == AT_FSTRONG_2) {
    sound_stop(sound_get("desp_spin"));
    if (!bullet_lost) {
        num_bullets--;
        nametag_white_flash = 1;
        var bullet_casing = instance_create(x, y-10, "obj_article3");
        bullet_casing.state = 00;
        bullet_casing.hsp = -3*spr_dir;
        bullet_casing.vsp = -6;
    }
}