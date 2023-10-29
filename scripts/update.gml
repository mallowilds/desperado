// update.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
// Code here is run every frame for your character.

/* Bullet Mechanic

You can have up to 6 bullets, which have stacking effects on damage. I have the basic damage mult setup, but a few things need to be added. 
-At 4+  bullets, i want there to be smoke particles that display around desperado. i still need to make these so dont worry about them rn
-Additionally, while at 4+ bullets, all attacks that deal more than 3% should layer a sound effect on top of the normal hit (Gonna change, for now use sound_get("desp_knock") [DONE]
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


//#region Flame management (drawn in pre_draw.gml, added by update/attack_update.gml)
for (var i = 0; i < ds_list_size(sparkle_list); i++) {
    var sp = ds_list_find_value(sparkle_list, i);
    sp.sp_lifetime++;
    if (sp.sp_lifetime >= sp.sp_max_lifetime) {
        ds_list_remove(sparkle_list, sp);
        i--;
    }
}

if (num_bullets >= 4 && get_gameplay_time() % 7 == 0) spawn_sparkle(get_gameplay_time()%17, get_gameplay_time()%37);
//#endregion


//#region Reset fractional damage on enemy death
with oPlayer {
    if (!clone && (state == PS_DEAD || state == PS_RESPAWN)) {
        u_mult_damage_buffer = 0;
    }
}
//#endregion



#define spawn_sparkle(seed1, seed2)
    var sparkle_type = random_func_2(seed1, 3, true);
    if (sparkle_type == 0) spawn_particle_random("fire1", 10, seed2);
    else if (sparkle_type == 1) spawn_particle_random("fire2", 15, seed2);
    else if (sparkle_type == 2) spawn_particle_random("fire3", 15, seed2);
    
#define spawn_particle_random(in_sprite, lifetime, seed)
    var min_rad = 34;
    var rad_range = 14;
    var y_offset = -40;
    var _rot = random_func_2(seed, 240, false) - 60;
    var _dist = min_rad + random_func_2(seed+1, rad_range, false);
    var _x = x + lengthdir_x(_dist, _rot);
    var _y = y + lengthdir_y(_dist, _rot) + y_offset;
    var sparkle = {
        sp_x : _x,
        sp_y : _y,
        sp_sprite_index : sprite_get(in_sprite),
        sp_max_lifetime : lifetime,
        sp_lifetime : 0,
        sp_spr_dir : spr_dir
    };
    ds_list_add(sparkle_list, sparkle);