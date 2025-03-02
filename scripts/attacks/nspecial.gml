// nspecial.gml
// Desperado shoots every bullet in his chamber in a hammer fan. This move gets sequentially stronger with every bullet shot,
// and at full bullets, becomes the strongest projectile in the game. Once used, you need to reload your bullets.

make_attack(AT_NSPECIAL,
    AG_CATEGORY, 2,
    AG_SPRITE, sprite_get("nspecial"),
    AG_NUM_WINDOWS, 4,
    AG_HAS_LANDING_LAG, 4,
    AG_OFF_LEDGE, 1,
    AG_AIR_SPRITE, sprite_get("nspecial"),
    AG_HURTBOX_SPRITE, sprite_get("nspecial_hurt"),
    AG_USES_CUSTOM_GRAVITY, 1,
)

make_window(AT_NSPECIAL, 1,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 18,
    AG_WINDOW_ANIM_FRAMES, 5,
    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX, sound_get("desp_twirl"),
    AG_WINDOW_SFX_FRAME, 0,
)

make_window(AT_NSPECIAL, 2,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 4,
    AG_WINDOW_ANIM_FRAMES, 2,
    AG_WINDOW_ANIM_FRAME_START, 5,
)

make_window(AT_NSPECIAL, 3,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 3,
    AG_WINDOW_ANIM_FRAMES, 1,
    AG_WINDOW_ANIM_FRAME_START, 7,
    AG_WINDOW_CUSTOM_GRAVITY, gravity_speed,
)

make_window(AT_NSPECIAL, 4,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 45,
    AG_WINDOW_ANIM_FRAMES, 6,
    AG_WINDOW_ANIM_FRAME_START, 8,
    AG_WINDOW_CUSTOM_GRAVITY, gravity_speed,
)

// No bullets window (needlessly high just in case something needs added)
make_window(AT_NSPECIAL, 9,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 24,
    AG_WINDOW_ANIM_FRAMES, 5,
    AG_WINDOW_ANIM_FRAME_START, 14,
    AG_WINDOW_CUSTOM_GRAVITY, gravity_speed,
)


set_num_hitboxes(AT_NSPECIAL, 0);

nspec_x_pos = 76;

// NSpec multihit
make_hitbox(AT_NSPECIAL, 1,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 2, // Note: spawned manually
    HG_WINDOW_CREATION_FRAME, 0,
    HG_LIFETIME, 3,

    HG_HITBOX_X, 106, // Note: overwriten; set left-most position above
    HG_HITBOX_Y, -58,
    HG_WIDTH, 60, // Note: overwritten to maximize length
    HG_HEIGHT, 40,
    HG_SHAPE, 1,
    HG_HITBOX_GROUP, 1,

    HG_PRIORITY, 2,
    HG_DAMAGE, 2,
    HG_ANGLE, 90,
    HG_ANGLE_FLIPPER, 9,
    HG_BASE_KNOCKBACK, 3,
    HG_KNOCKBACK_SCALING, 0,
    HG_BASE_HITPAUSE, 1,
    HG_EXTRA_HITPAUSE, 3,
    HG_HITPAUSE_SCALING, 0.3,
    HG_HITSTUN_MULTIPLIER, 0.9,
    HG_SDI_MULTIPLIER, 0.01,
    HG_EXTENDED_PARRY_STUN, 1,

    HG_VISUAL_EFFECT, 1, // Spawned manually for positioning reasons
    HG_VISUAL_EFFECT_X_OFFSET, 32,
    HG_VISUAL_EFFECT_Y_OFFSET, 5,
    HG_HIT_SFX, asset_get("sfx_blow_weak1"),
    HG_HIT_PARTICLE_NUM, 1,
)

// NSpec finisher
make_hitbox(AT_NSPECIAL, 2,
    HG_HITBOX_TYPE, 1,
    HG_WINDOW, 3, // Note: spawned manually
    HG_WINDOW_CREATION_FRAME, 0,
    HG_LIFETIME, 3,

    HG_HITBOX_X, 106, // Note: overwriten; set left-most position above
    HG_HITBOX_Y, -58,
    HG_WIDTH, 60, // Note: overwritten to maximize length
    HG_HEIGHT, 40,
    HG_SHAPE, 1,
    HG_HITBOX_GROUP, 2,

    HG_PRIORITY, 2,
    HG_DAMAGE, 4,
    HG_ANGLE, 45,
    //HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 9, // Tampered with in attack_update
    HG_KNOCKBACK_SCALING, .8, // Tampered with in attack_update
    HG_BASE_HITPAUSE, 10,
    HG_HITPAUSE_SCALING, .9,
    HG_EXTRA_HITPAUSE, 5,
    //HG_HITSTUN_MULTIPLIER, .8,
    HG_EXTENDED_PARRY_STUN, 1,

    HG_VISUAL_EFFECT, 1, // Spawned manually for positioning reasons
    HG_HIT_SFX, asset_get("sfx_blow_heavy1"),
    HG_HIT_PARTICLE_NUM, 1,
)

// NSpec reflection
make_hitbox(AT_NSPECIAL, 3,
    HG_HITBOX_TYPE, 2,
    HG_WINDOW, 999,
    HG_WINDOW_CREATION_FRAME, 0,
    HG_LIFETIME, 3,

    //HG_HITBOX_X, 106,
    //HG_HITBOX_Y, -60,
    HG_WIDTH, 52,
    HG_HEIGHT, 52,
    HG_SHAPE, 0,

    HG_PRIORITY, 2,
    HG_DAMAGE, 4,
    HG_ANGLE, 45,
    //HG_ANGLE_FLIPPER, 6,
    HG_BASE_KNOCKBACK, 9, // Tampered with in article1_update
    HG_KNOCKBACK_SCALING, .7, // Tampered with in article1_update
    HG_BASE_HITPAUSE, 10,
    HG_HITPAUSE_SCALING, .9,
    HG_EXTRA_HITPAUSE, 5,
    HG_HITSTUN_MULTIPLIER, .7,
    HG_HIT_LOCKOUT, 3,

    HG_VISUAL_EFFECT, vfx_bullseye,
    HG_HIT_SFX, asset_get("sfx_blow_heavy1"),
    HG_HIT_PARTICLE_NUM, 1,
    
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