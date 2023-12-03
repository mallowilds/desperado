/* dspecial.gml
Dspecial is Reload - It is what it says on the tin. He will spin the chamber and then put a bullet into it, snapping it shut.

If he does this with 6 bullets loaded, he'll spin the chamber but not do anything after.
The move will have airstall, lowering your fall speed while using the attack. You can hang in the air as a timing mixup on recovery, but its really punishable.

anim wise, after the startup i want the spinning animation (4 frames) to loop 3 or so times before he throws the bullet in.


*/
make_attack(AT_DSPECIAL,
    AG_CATEGORY, 2,
    AG_SPRITE, sprite_get("dspecial"),
    AG_NUM_WINDOWS, 3,
    AG_HAS_LANDING_LAG, 4,
    AG_OFF_LEDGE, 1,
    AG_AIR_SPRITE, sprite_get("dspecial"),
    AG_HURTBOX_SPRITE, sprite_get("dspecial_hurt"),
    AG_USES_CUSTOM_GRAVITY, 1, // Tampered with in attack_update
    AG_OFF_LEDGE, 0,
)

make_window(AT_DSPECIAL, 1, //start
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 4,
    AG_WINDOW_SFX, sound_get("desp_spin"),
    AG_WINDOW_CUSTOM_GRAVITY, 0.3,
)

make_window(AT_DSPECIAL, 2, //loop
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 45,
    AG_WINDOW_ANIM_FRAMES, 8,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_CUSTOM_GRAVITY, 0.3,
)

make_window(AT_DSPECIAL, 3, //loop
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 35,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 10,
    AG_WINDOW_CUSTOM_GRAVITY, 0.3,
)

set_num_hitboxes(AT_DSPECIAL, 0);


// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define make_attack // Version 0
    // make_attack(_attack_name, (value_name, value)... )
    // Sets attack values for the given attack.
    // e.g. make_attack(AT_BAIR,
    //     AG_CATEGORY, 1,
    //     AG_SPRITE, sprite_get("bair")
    // )
    var _attack_name = argument[0]
    for(var i=1; i<=argument_count-1; i+=2) {
        set_attack_value(
            _attack_name, argument[i], argument[i+1]
        )
    }

#define make_window // Version 0
    // make_window(_attack_name, _index, (value_name, value)... )
    // Sets window values for the given window.
    // e.g.make_window(AT_BAIR, 1,
    //         AG_WINDOW_TYPE, 1,
    //         AG_WINDOW_LENGTH, 6
    //     )
    var _attack_name = argument[0];
    var _index = argument[1];
    for(var i=2; i<=argument_count-1; i+=2) {
        set_window_value(
            _attack_name, _index, argument[i], argument[i+1]
        )
    }

#define make_hitbox // Version 0
    // make_hitbox(_attack_name, _index, (value_name, value)... )
    // Sets hitbox values for the given hitbox.
    // e.g. make_hitbox(AT_BAIR, 1,
    //         HG_PARENT_HITBOX, 1,
    //         HG_HITBOX_TYPE, 1
    //     );
    var _attack_name = argument[0];
    var _index = argument[1];
    for(var i=2; i<=argument_count-1; i+=2) {
        set_hitbox_value(
            _attack_name, _index, argument[i], argument[i+1]
        )
    }
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion