// dattack_skullless.gml

make_attack(AT_EXTRA_2,
    AG_SPRITE, sprite_get("dattack_skulless"),
    AG_NUM_WINDOWS, 5,
    AG_AIR_SPRITE, sprite_get("dattack_skulless"),
    AG_HURTBOX_SPRITE, sprite_get("dattack_skulless_hurt"),
    AG_MUNO_ATTACK_NAME, "Skulless DAttack",
)

make_window(AT_EXTRA_2, 1, //startup
    AG_WINDOW_LENGTH, 7,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"),
    AG_WINDOW_SFX_FRAME, 3,
)

make_window(AT_EXTRA_2, 2,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_HSPEED, 8,

)

make_window(AT_EXTRA_2, 3,
    AG_WINDOW_LENGTH, 2,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 3,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_HSPEED, 2,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, .8,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"),

)

make_window(AT_EXTRA_2, 4,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_HSPEED, 3,
    AG_WINDOW_HSPEED_TYPE, 1,
)
make_window(AT_EXTRA_2, 5,
    
    AG_WINDOW_LENGTH, 12,
    AG_WINDOW_ANIM_FRAMES, 3,
    AG_WINDOW_ANIM_FRAME_START, 5,
    AG_WINDOW_HAS_WHIFFLAG, 1,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, 3,
)

set_num_hitboxes(AT_EXTRA_2, 2)

make_hitbox(AT_EXTRA_2, 1,
    HG_HITBOX_TYPE, 1,

    HG_WINDOW, 2,
    HG_LIFETIME, 2,
    HG_MUNO_HITBOX_MISC_ADD, "Can cancel into Up Strong on hit.",
    
    HG_HITBOX_X, 20,
    HG_HITBOX_Y, -10,
    HG_WIDTH, 60,
    HG_HEIGHT, 20,
    HG_SHAPE, 2,


    HG_PRIORITY, 2,
    HG_DAMAGE, 3,
    HG_ANGLE, 40,
    //HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 5.5,
    HG_BASE_HITPAUSE, 3,
    HG_KNOCKBACK_SCALING, 0,


    HG_HIT_SFX, asset_get("sfx_blow_weak1"),

)

make_hitbox(AT_EXTRA_2, 2,
    HG_HITBOX_TYPE, 1,

    HG_WINDOW, 4,
    HG_LIFETIME, 3,
    HG_HITBOX_GROUP, -1,
    
    
    HG_HITBOX_X, 30,
    HG_HITBOX_Y, -30,
    HG_WIDTH, 60,
    HG_HEIGHT, 60,



    HG_PRIORITY, 2,
    HG_DAMAGE, 4,
    HG_ANGLE, 80,
    //HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 7,
    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .5,

    HG_KNOCKBACK_SCALING, .4,


    HG_HIT_SFX, asset_get("sfx_blow_medium3"),

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