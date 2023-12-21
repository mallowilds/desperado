// dair.gml

make_attack(AT_DAIR,
    AG_CATEGORY, 1,
    AG_SPRITE, sprite_get("dair"),
    AG_NUM_WINDOWS, 3,
    AG_HAS_LANDING_LAG, 1,
    AG_LANDING_LAG, 6,
    AG_HURTBOX_SPRITE, sprite_get("dair_hurt"),
    AG_USES_CUSTOM_GRAVITY, 1,
    AG_OFF_LEDGE, 1,
)

make_window(AT_DAIR, 1,
    AG_WINDOW_LENGTH, 9,
    AG_WINDOW_ANIM_FRAMES, 2,
    
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"),
    AG_WINDOW_SFX_FRAME, 8,
    AG_WINDOW_CUSTOM_GRAVITY, 0,
)

make_window(AT_DAIR, 2, //down
    AG_WINDOW_LENGTH, 8,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_CUSTOM_AIR_FRICTION, 0.4,
    AG_WINDOW_CUSTOM_GRAVITY, 0,
        
    AG_WINDOW_SKULL_GRABBOX_X, 36,
    AG_WINDOW_SKULL_GRABBOX_Y, -10,
    AG_WINDOW_SKULL_GRABBOX_W, 80,
    AG_WINDOW_SKULL_GRABBOX_H, 80,
)

make_window(AT_DAIR, 3, 
    AG_WINDOW_LENGTH, 12,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 4,
    AG_WINDOW_HAS_WHIFFLAG, 1,
    AG_WINDOW_CUSTOM_GRAVITY, 0,
)

make_window(AT_DAIR, 4, //hitgrab startup
    AG_WINDOW_LENGTH, 7,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"),
    AG_WINDOW_SFX_FRAME, 6,
    AG_WINDOW_ANIM_FRAME_START, 6,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, 0.6,
    AG_WINDOW_CUSTOM_GRAVITY, 1.5,
)

make_window(AT_DAIR, 5,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, 0.6,
    AG_WINDOW_CUSTOM_GRAVITY, 1.5,
)

make_window(AT_DAIR, 6,
    AG_WINDOW_LENGTH, 13,
    AG_WINDOW_ANIM_FRAMES, 4,
    AG_WINDOW_ANIM_FRAME_START, 8,
    AG_WINDOW_HAS_WHIFFLAG, 1,
    AG_WINDOW_HAS_CUSTOM_FRICTION, 1,
    AG_WINDOW_CUSTOM_GROUND_FRICTION, 0.6,
    AG_WINDOW_CUSTOM_GRAVITY, 1.5,
)

set_num_hitboxes(AT_DAIR, 2)

make_hitbox(AT_DAIR, 1,
    HG_WINDOW, 2,
    HG_LIFETIME, 8,
    HG_HITBOX_GROUP, 1,
    HG_HITBOX_TYPE, 1,
    
    HG_HITBOX_X, 36,
    HG_HITBOX_Y, 0,
    HG_WIDTH, 75,
    HG_HEIGHT, 75,
    
    HG_PRIORITY, 2,
    HG_DAMAGE, 3,
    HG_ANGLE, 55,
    HG_BASE_KNOCKBACK, 9,
    HG_KNOCKBACK_SCALING, 0,
    HG_BASE_HITPAUSE, 4,
    HG_HITPAUSE_SCALING, 0.5,
    HG_HITSTUN_MULTIPLIER, 0.8,
    
    HG_TECHABLE, 1,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),

)

make_hitbox(AT_DAIR, 2,
    HG_WINDOW, 5,
    HG_LIFETIME, 3,
    HG_HITBOX_GROUP, 2,
    HG_HITBOX_TYPE, 1,
    
    HG_HITBOX_X, 30,
    HG_HITBOX_Y, -24,
    HG_WIDTH, 50,
    HG_HEIGHT, 90,
    
    HG_PRIORITY, 2,
    HG_DAMAGE, 5,
    HG_ANGLE, 60,
    HG_BASE_KNOCKBACK, 5,
    HG_KNOCKBACK_SCALING, 0.4,
    HG_BASE_HITPAUSE, 6,
    HG_HITPAUSE_SCALING, 0.4,
    HG_VISUAL_EFFECT, 304,
    
    HG_HIT_SFX, asset_get("sfx_blow_heavy2"),
    HG_VISUAL_EFFECT, vfx_bone_large,

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

#macro HIT_FRAMES 12
#define _get_hit_frames()
    return HIT_FRAMES
#macro HIT_FRAME_START 6
#define _get_hit_frame_start()
    return HIT_FRAME_START
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion