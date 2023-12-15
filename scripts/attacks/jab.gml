// jab.gml

make_attack(AT_JAB,
    AG_SPRITE, sprite_get("jab"),
    AG_NUM_WINDOWS, 9,
    AG_HURTBOX_SPRITE, sprite_get("jab_hurt"),
    AG_MUNO_ATTACK_MISC, "During the endlag of Jab 3, this move loads a bullet.",
)

make_window(AT_JAB, 1,
    AG_WINDOW_LENGTH, 4,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"),
    AG_WINDOW_SFX_FRAME, 1,
    AG_WINDOW_HSPEED, 1
)

make_window(AT_JAB, 2,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 1,

    AG_WINDOW_HSPEED, 2,
)

make_window(AT_JAB, 3,
    AG_WINDOW_LENGTH, 13,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_CANCEL_TYPE, 1,
    AG_WINDOW_CANCEL_FRAME, 5,
)

make_window(AT_JAB, 4,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_HSPEED, 2,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_weak2"),
    AG_WINDOW_SFX_FRAME, 2,
)

make_window(AT_JAB, 5,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 5,
)

make_window(AT_JAB, 6,
    AG_WINDOW_LENGTH, 15,
    AG_WINDOW_CANCEL_TYPE, 1,
    AG_WINDOW_CANCEL_FRAME, 6,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 6,
)

make_window(AT_JAB, 7,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_HSPEED, 6,
    AG_WINDOW_SFX, asset_get("sfx_swipe_heavy1"),
    AG_WINDOW_SFX_FRAME, 4,
)

make_window(AT_JAB, 8,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 9,
)

make_window(AT_JAB, 9,
    AG_WINDOW_LENGTH, 33,
    AG_WINDOW_ANIM_FRAMES, 5,
    AG_WINDOW_ANIM_FRAME_START, 10,
    AG_WINDOW_HAS_WHIFFLAG, 1
)

set_num_hitboxes(AT_JAB, 3);

make_hitbox(AT_JAB, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 40,
    HG_HITBOX_Y, -35,
    HG_WIDTH, 100,
    HG_HEIGHT, 50,
    
    HG_PRIORITY, 2,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 2,
    HG_ANGLE, 361,
    HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 4,
    HG_BASE_HITPAUSE, 5,
    
    HG_VISUAL_EFFECT_X_OFFSET, 32,
    HG_VISUAL_EFFECT_Y_OFFSET, -10,
    HG_HIT_SFX, asset_get("sfx_blow_weak1"),

    HG_FORCE_FLINCH, 1,
    HG_IGNORES_PROJECTILES, 1,
)

make_hitbox(AT_JAB, 2,
    HG_WINDOW, 5,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 40,
    HG_HITBOX_Y, -35,
    HG_WIDTH, 105,
    HG_HEIGHT, 55,
    
    HG_PRIORITY, 1,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 2,
    HG_ANGLE, 361,
    HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 4,
    HG_BASE_HITPAUSE, 5,
    
    HG_VISUAL_EFFECT_X_OFFSET, 32,
    HG_VISUAL_EFFECT_Y_OFFSET, -10,
    HG_HIT_SFX, asset_get("sfx_blow_weak2"),

    HG_IGNORES_PROJECTILES, 1,
)

make_hitbox(AT_JAB, 3,
    HG_WINDOW, 8,
    HG_LIFETIME, 2,

    HG_HITBOX_X, 35,
    HG_HITBOX_Y, -40,
    HG_WIDTH, 95,
    HG_HEIGHT, 60,
    
    HG_PRIORITY, 3,
    HG_HITBOX_GROUP, -1,
    HG_DAMAGE, 3,
    HG_ANGLE, 361,
    HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 8,
    HG_KNOCKBACK_SCALING, 0.4,
    HG_BASE_HITPAUSE, 8,
    HG_HITPAUSE_SCALING, 0.8,
        
    //HG_VISUAL_EFFECT, hfx_bone_large,
    HG_HIT_SFX, asset_get("sfx_blow_heavy2"),
    HG_EXTRA_CAMERA_SHAKE, 2,

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