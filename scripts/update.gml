// update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Code here is run every frame for your character.

/* Bullet Mechanic

You can have up to 6 bullets, which have stacking effects on damage. I have the basic damage mult setup, but a few things need to be added. 
-At 4+  bullets, i want there to be smoke particles that display around desperado. i still need to make these so dont worry about them rn
-Additionally, while at 4+ bullets, all attacks that deal more than 3% should layer a sound effect on top of the normal hit (Gonna change, for now use sound_get("desp_knock")
-At 6 bullets, the outline should gradient from black to the 'FireOutline' color, the last extra slot. If possible. If not just use the default color (130, 0, 0)
//i still need to update colors.gml with the unique fireoutline coloirs most of them are red rn, am lazy
-When nspecial is used, each bullet is fired and removed.
-When fstrong is used (dw about this yet gonna animate first), 1 bullet is removed. If no bullets, its just a punch.

*/
if state == PS_CROUCH && state_timer == 1 && !hitpause {
    //sound_stop(wavedashsfx)
    //sound_play(wavedashsfx, 0, noone, 1, 1.3)

}
if state == PS_AIR_DODGE && state_timer == 0 && !hitpause {
    sound_play(adodge)
}
if state == PS_WAVELAND && state_timer == 0 && !hitpause {
    sound_stop(adodge)
    sound_play(asset_get("sfx_waveland_zet"), 0, noone, 0.4, 0.97)
    sound_play(wavedashsfx, 0, noone, 1, 1.3)

}

with (asset_get("pHitBox")){
    if (player == other.player) {
        damage = round(damage*other.damage_mult)
    }
}

switch(bullets) {
    case 0:
        damage_mult = 1
        break;
    case 1:
        damage_mult = 1.125
        break;
    case 2:
        damage_mult = 1.25
        break;
    case 3:
        damage_mult = 1.375
        break;
    case 4:
        damage_mult = 1.50
        break;
    case 5:
        damage_mult = 1.625
        break;
    case 6:
        damage_mult = 1.75
        break;
}