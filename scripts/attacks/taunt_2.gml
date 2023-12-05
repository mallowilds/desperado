// taunt.gml
/*
Taunt is one of the moves that i want the chamber to spin with.


*/

make_attack(AT_TAUNT_2,
    AG_SPRITE, sprite_get("taunt_2"),
    AG_NUM_WINDOWS, 2,
    AG_HAS_LANDING_LAG, 3,
    AG_OFF_LEDGE, 0,
    AG_HURTBOX_SPRITE, asset_get("ex_guy_hurt_box"),
)

make_window(AT_TAUNT_2, 1,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 12,
    AG_WINDOW_ANIM_FRAMES, 4,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, sound_get("desp_shot"),
    AG_WINDOW_SFX_FRAME, 10,
) 

make_window(AT_TAUNT_2, 2,
    AG_WINDOW_TYPE, 2,
    AG_WINDOW_LENGTH, 15,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 4,
)


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
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion