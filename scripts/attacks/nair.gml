// nair.gml

make_attack(AT_NAIR, 
    AG_CATEGORY, 1,
    AG_SPRITE, sprite_get("nair"),
    AG_HAS_LANDING_LAG, 1,
    AG_LANDING_LAG, 4,
    AG_HURTBOX_SPRITE, sprite_get("nair_hurt"),
    AG_NUM_WINDOWS, 6,
)

make_window(AT_NAIR, 1, //startup 1
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"),
    AG_WINDOW_SFX_FRAME, 4,
)

make_window(AT_NAIR, 2, //active 2
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 2,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 2,

)

make_window(AT_NAIR, 3, //endlag 1
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 16,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 3,
   // AG_WINDOW_HAS_WHIFFLAG, 1,
)

make_window(AT_NAIR, 4, //startup 2
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 5,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"),
    AG_WINDOW_SFX_FRAME, 4,
)

make_window(AT_NAIR, 5, //active 2
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 2,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 6,

)

make_window(AT_NAIR, 6, //endlag 1
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 16,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_HAS_WHIFFLAG, 1,
)

set_num_hitboxes(AT_NAIR, 3);

make_hitbox(AT_NAIR, 1,
    HG_HITBOX_TYPE, 1,

    HG_WINDOW, 2,
    HG_LIFETIME, 4,

    HG_HITBOX_X, -28,
    HG_HITBOX_Y, -2,

    HG_WIDTH, 68,
    HG_HEIGHT, 63,

    HG_PRIORITY, 1,
    HG_DAMAGE, 4,
    HG_ANGLE, 50,
    HG_BASE_KNOCKBACK, 6,
    HG_KNOCKBACK_SCALING, .1,
    HG_BASE_HITPAUSE, 4,
    HG_HITPAUSE_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .8,
    
    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
);

make_hitbox(AT_NAIR, 2,
    HG_HITBOX_TYPE, 1,

    HG_WINDOW, 2,
    HG_LIFETIME, 4,

    HG_HITBOX_X, 31,
    HG_HITBOX_Y, -8,

    HG_WIDTH, 68,
    HG_HEIGHT, 65,

    HG_PRIORITY, 1,
    HG_DAMAGE, 3,
    HG_ANGLE, 50,
    HG_BASE_KNOCKBACK, 6,
    HG_KNOCKBACK_SCALING, .1,
    HG_BASE_HITPAUSE, 4,
    HG_HITPAUSE_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .8,


    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
);


make_hitbox(AT_NAIR, 3,
    HG_HITBOX_TYPE, 1,

    HG_WINDOW, 5,
    HG_LIFETIME, 2,
    
    HG_HITBOX_X, 21,
    HG_HITBOX_Y, -4,
    HG_WIDTH, 66,
    HG_HEIGHT, 95,
    
    HG_PRIORITY, 1,
    HG_DAMAGE, 4,
    HG_ANGLE, 60,
    //HG_ANGLE_FLIPPER, 3,
    HG_BASE_KNOCKBACK, 6,
    HG_KNOCKBACK_SCALING, .5,
    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .6,
    HG_VISUAL_EFFECT, 304,
    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
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