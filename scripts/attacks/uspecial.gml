// uspecial.gml

make_attack(AT_USPECIAL,
    AG_CATEGORY, 2,
    AG_SPRITE, sprite_get("uspecial"),
    AG_NUM_WINDOWS, 3,
    AG_HAS_LANDING_LAG, 4,
    AG_OFF_LEDGE, 1,
    AG_AIR_SPRITE, sprite_get("uspecial"),
    AG_HURTBOX_SPRITE, sprite_get("uspecial_hurt"),
    AG_USES_CUSTOM_GRAVITY, 1,
)

make_window(AT_USPECIAL, 1, //Startup
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 9,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_VSPEED_TYPE, 1,
    AG_WINDOW_VSPEED, 0,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 6,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"),
)

make_window(AT_USPECIAL, 2, //dash
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 8,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_VSPEED_TYPE, 2,
    AG_WINDOW_HSPEED_TYPE, 2,
    AG_WINDOW_VSPEED, -13,
    AG_WINDOW_HSPEED, 4,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_CUSTOM_GRAVITY, 1.2,
    
    AG_WINDOW_SKULL_GRABBOX_X, 36,
    AG_WINDOW_SKULL_GRABBOX_Y, -53,
    AG_WINDOW_SKULL_GRABBOX_W, 40,
    AG_WINDOW_SKULL_GRABBOX_H, 74,
)

make_window(AT_USPECIAL, 3, //endlag
    AG_WINDOW_TYPE, 7,
    AG_WINDOW_LENGTH, 8,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_CUSTOM_GRAVITY, 1,
)

make_window(AT_USPECIAL, 4, //skull hop startup
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 2,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_VSPEED_TYPE, 1,
    AG_WINDOW_VSPEED, 0,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"),
)


make_window(AT_USPECIAL, 5, //skull hop
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 7,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_VSPEED_TYPE, 2,
    AG_WINDOW_HSPEED_TYPE, 2,
    AG_WINDOW_VSPEED, -7,
    AG_WINDOW_HSPEED, 3,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_CUSTOM_GRAVITY, gravity_speed,
)


set_num_hitboxes(AT_USPECIAL, 5);

make_hitbox(AT_USPECIAL, 1,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 12,

    HG_HITBOX_X, 36,
    HG_HITBOX_Y, -60,
    HG_WIDTH, 90,
    HG_HEIGHT, 100,
    HG_SHAPE, 0,

    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 7,
    HG_ANGLE, 60,
    //HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 7,
    HG_KNOCKBACK_SCALING, .3,
    HG_BASE_HITPAUSE, 4,
    HG_HITPAUSE_SCALING, .4,
    HG_HIT_SFX, asset_get("sfx_blow_medium2"),
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