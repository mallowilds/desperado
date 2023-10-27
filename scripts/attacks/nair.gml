// nair.gml

make_attack(AT_NAIR, 
    AG_CATEGORY, 1,
    AG_SPRITE, sprite_get("nair"),
    AG_HAS_LANDING_LAG, 1,
    AG_LANDING_LAG, 4,
    AG_HURTBOX_SPRITE, sprite_get("nair_hurt"),
    AG_NUM_WINDOWS, 4,
)

make_window(AT_NAIR, 1,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 1,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"),
    AG_WINDOW_SFX_FRAME, 4,
)

make_window(AT_NAIR, 2,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 8,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 3,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"),
    AG_WINDOW_SFX_FRAME, 7,
)

make_window(AT_NAIR, 3,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 4,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 6,
)

make_window(AT_NAIR, 4,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 16,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_HAS_WHIFFLAG, 4,
)

set_num_hitboxes(AT_NAIR, 2);

make_hitbox(AT_NAIR, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 4,

    HG_HITBOX_X, 40,
    HG_HITBOX_Y, -34,

    HG_WIDTH, 50,
    HG_HEIGHT, 106,

    HG_PRIORITY, 1,
    HG_DAMAGE, 6,
    HG_ANGLE, 45,
    HG_BASE_KNOCKBACK, 6,
    HG_KNOCKBACK_SCALING, .5,
    HG_BASE_HITPAUSE, 5,
    HG_HITPAUSE_SCALING, .5,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
);

make_hitbox(AT_NAIR, 2,
    HG_WINDOW, 3,
    HG_LIFETIME, 4,
    
    HG_HITBOX_X, -46,
    HG_HITBOX_Y, -20,
    HG_WIDTH, 50,
    HG_HEIGHT, 88,
    
    HG_PRIORITY, 1,
    HG_DAMAGE, 6,
    HG_ANGLE, 85,
    //HG_ANGLE_FLIPPER, 3,
    HG_BASE_KNOCKBACK, 6,
    HG_KNOCKBACK_SCALING, .5,
    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .6,
    
    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
    HG_HITBOX_GROUP, 2,
);

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