// ftilt.gml

make_attack(AT_EXTRA_3, 
    AG_SPRITE, sprite_get("ftilt_emp"),
    AG_NUM_WINDOWS, 4,
    AG_HURTBOX_SPRITE, sprite_get("ftilt_hurt"),
    AG_MUNO_ATTACK_NAME, "Scorching FTilt",
    AG_MUNO_ATTACK_MISC, "With at least 4 bullets, this move becomes a multihit.",
)

make_window(AT_EXTRA_3, 1,
    AG_WINDOW_LENGTH, 7,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 6,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"),
    AG_WINDOW_HSPEED, 2,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, 0.05,
    AG_WINDOW_CUSTOM_AIR_FRICTION, 0.05,
)

make_window(AT_EXTRA_3, 2,
    AG_WINDOW_LENGTH, 4,
    //AG_WINDOW_HSPEED, 1, 
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 2,

)

make_window(AT_EXTRA_3, 3,
    AG_WINDOW_LENGTH, 4,
    //AG_WINDOW_HSPEED, 1, 
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 3,

)



make_window(AT_EXTRA_3, 4,
    AG_WINDOW_LENGTH, 13,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_HAS_WHIFFLAG, 4,
)

set_num_hitboxes(AT_EXTRA_3, 3)

make_hitbox(AT_EXTRA_3, 1,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 60,
    HG_HITBOX_Y, -27,
    HG_WIDTH, 102,
    HG_HEIGHT, 61,
    HG_SHAPE, 2,

    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 2,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 4,
    HG_BASE_KNOCKBACK, 3,
    HG_BASE_HITPAUSE, 3,
    HG_HIT_SFX, asset_get("sfx_blow_weak1"),
)

make_hitbox(AT_EXTRA_3, 2,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 2,
    HG_WINDOW_CREATION_FRAME, 2,

    HG_HITBOX_X, 60,
    HG_HITBOX_Y, -27,
    HG_WIDTH, 102,
    HG_HEIGHT, 61,
    HG_SHAPE, 2,

    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 2,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 4,
    HG_BASE_KNOCKBACK, 3,
    HG_BASE_HITPAUSE, 3,
    HG_HIT_SFX, asset_get("sfx_blow_weak2"),
)

make_hitbox(AT_EXTRA_3, 3,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 3,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 60,
    HG_HITBOX_Y, -27,
    HG_WIDTH, 106,
    HG_HEIGHT, 74,
    HG_SHAPE, 2,

    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 3,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 7,
    HG_KNOCKBACK_SCALING, .5,
    HG_BASE_HITPAUSE, 8,
    HG_HITPAUSE_SCALING, .8,
    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
)
/*
make_hitbox(AT_EXTRA_3, 2,
    HG_WINDOW, 3,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 50,
    HG_HITBOX_Y, -30,
    HG_WIDTH, 100,
    HG_HEIGHT, 60,
    HG_SHAPE, 1,

    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 5,
    HG_ANGLE, 361,
    HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 7,
    HG_KNOCKBACK_SCALING, .5,
    HG_BASE_HITPAUSE, 6,
    HG_HITPAUSE_SCALING, .6,

    HG_VISUAL_EFFECT, 301,
    HG_VISUAL_EFFECT_X_OFFSET, 0,
    HG_VISUAL_EFFECT_Y_OFFSET, 0,
    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
    HG_EXTRA_CAMERA_SHAKE, 2,
    HG_IGNORES_PROJECTILES, 1,
)*/

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