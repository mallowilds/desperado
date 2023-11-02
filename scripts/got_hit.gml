// got_hit.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#got-hit-gml
// Called when you get hit



// Reset anti-stall checks
dairs_used = 0;
move_cooldown[AT_DSPECIAL] = 0;



// SFX checks
if ((prev_state == PS_ATTACK_AIR || prev_state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL) {
    sound_stop(sound_get("desp_whisper"));
}


// holding_bullet stuff is in update. The game doesn't seem to like create_hitbox operations in here