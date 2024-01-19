// got_hit.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-hit-gml
// Called when you get hit


if (prev_state == PS_ATTACK_GROUND && attack == AT_FSTRONG_2) {
    if (!bullet_lost) {
        num_bullets--;
        nametag_white_flash = 1;
        var bullet_casing = instance_create(x, y-10, "obj_article3");
        bullet_casing.state = 00;
        bullet_casing.hsp = -3*spr_dir;
        bullet_casing.vsp = -6;
    }
}


// Reset anti-stall checks
move_cooldown[AT_NSPECIAL] = 0;


// SFX checks

if (reload_anim_state == 1 || reload_anim_state == 2) {
    reload_anim_state = 0;
    reload_anim_timer = 0;
    sound_stop(spin_sfx_instance);
	spin_sfx_instance = noone;
}

if ((prev_state == PS_ATTACK_AIR || prev_state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL) {
    sound_stop(whisper_sfx_instance);
    whisper_sfx_instance = noone;
}

if (prev_state == PS_ATTACK_AIR && attack == AT_BAIR) {
    sound_stop(bair_sfx_instance);
    bair_sfx_instance = noone;
}