// fspecial.gml

make_attack(AT_FSPECIAL,
    AG_CATEGORY, 2,
    AG_SPRITE, sprite_get("fspec"),
    AG_NUM_WINDOWS, 3,
    AG_HAS_LANDING_LAG, 4,
    AG_AIR_SPRITE, sprite_get("fspec"),
    AG_HURTBOX_SPRITE, sprite_get("fspec_hurt"),
)

make_window(AT_FSPECIAL, 1,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 10,
    AG_WINDOW_ANIM_FRAMES, 2,

    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"),
    AG_WINDOW_SFX_FRAME, 8,
)

make_window(AT_FSPECIAL, 2,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 5,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 2,
    AG_WINDOW_VSPEED_TYPE, 1,
    AG_WINDOW_VSPEED, -3,
)

make_window(AT_FSPECIAL, 3,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 16,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 3,
)

set_num_hitboxes(AT_FSPECIAL, 1);

make_hitbox(AT_FSPECIAL, 1,
    HG_HITBOX_TYPE, 2,
    HG_LIFETIME, 2,
    HG_WIDTH, 50,
    HG_HEIGHT, 50,
    HG_PRIORITY, 2,
    HG_DAMAGE, 4,
    HG_ANGLE, 70,
    HG_BASE_KNOCKBACK, 8,
    HG_KNOCKBACK_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .7,

    HG_BASE_HITPAUSE, 6,
    HG_HITPAUSE_SCALING, .3,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
    
    HG_PROJECTILE_SPRITE, sprite_get("null"),
    HG_PROJECTILE_DESTROY_EFFECT, vfx_null,
    HG_PROJECTILE_MASK, -1,
    HG_PROJECTILE_IS_TRANSCENDENT, 1,
    HG_PROJECTILE_ENEMY_BEHAVIOR, 1,
    HG_PROJECTILE_GROUND_BEHAVIOR, 1,
    HG_PROJECTILE_WALL_BEHAVIOR, 1,
    HG_PROJECTILE_UNBASHABLE, 1,
    HG_PROJECTILE_DOES_NOT_REFLECT, 1,
    HG_PROJECTILE_PARRY_STUN, 1,
    HG_EXTENDED_PARRY_STUN, 1,
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