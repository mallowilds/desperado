// _skull_hitboxes.gml (index 42)
// This is not an actual attack! Hitboxes for the skull's sync attacks are stored here so as not to cause problems for woodcock.
// If this index is needed in the future, they can be safely moved elsewhere.

make_attack(42,
    AG_CATEGORY, 2,
    AG_SPRITE, sprite_get("fspecial"),
    AG_NUM_WINDOWS, 1,
    AG_AIR_SPRITE, sprite_get("fspecial"),
    AG_HURTBOX_SPRITE, sprite_get("fspecial_hurt"),
    AG_MUNO_ATTACK_NAME, "Skull Sync Attack Hitboxes",
)

make_window(42, 1,
    AG_WINDOW_TYPE, 1,
    AG_WINDOW_LENGTH, 1,
    AG_WINDOW_ANIM_FRAMES, 1,

    AG_WINDOW_HAS_SFX, 1,
    AG_WINDOW_SFX_FRAME, 8,
)

set_num_hitboxes(42, 3);


//#region Skull NAir
make_hitbox(42, 1,
    HG_HITBOX_TYPE, 2,
    HG_LIFETIME, 4,
    
    // These are used by and relative to the article.
    HG_WINDOW_CREATION_FRAME, 1,
    HG_HITBOX_X, 36,
    HG_HITBOX_Y, -36,
    
    HG_WIDTH, 50,
    HG_HEIGHT, 80,
    HG_PRIORITY, 2,
    HG_DAMAGE, 6,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 7, // Towards desperado
    HG_BASE_KNOCKBACK, 8,
    HG_KNOCKBACK_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .7,

    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .7,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
    
    HG_PROJECTILE_SPRITE, sprite_get("null"),
    HG_PROJECTILE_DESTROY_EFFECT, hfx_null,
    HG_PROJECTILE_MASK, -1,
    HG_PROJECTILE_IS_TRANSCENDENT, 1,
    HG_PROJECTILE_ENEMY_BEHAVIOR, 1,
    HG_PROJECTILE_GROUND_BEHAVIOR, 1,
    HG_PROJECTILE_WALL_BEHAVIOR, 1,
    HG_PROJECTILE_UNBASHABLE, 1,
    HG_PROJECTILE_DOES_NOT_REFLECT, 1,
    HG_PROJECTILE_PARRY_STUN, 1,
    HG_EXTENDED_PARRY_STUN, 1,
    HG_PROJECTILE_PLASMA_SAFE, 1,
)

make_hitbox(42, 2,
    HG_HITBOX_TYPE, 2,
    HG_LIFETIME, 4,
    
    // These are used by and relative to the article.
    HG_WINDOW_CREATION_FRAME, 3,
    HG_HITBOX_X, 16,
    HG_HITBOX_Y, -56,
    
    HG_WIDTH, 80,
    HG_HEIGHT, 50,
    HG_PRIORITY, 2,
    HG_DAMAGE, 6,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 7, // Towards desperado
    HG_BASE_KNOCKBACK, 8,
    HG_KNOCKBACK_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .7,

    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .7,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
    
    HG_PROJECTILE_SPRITE, sprite_get("null"),
    HG_PROJECTILE_DESTROY_EFFECT, hfx_null,
    HG_PROJECTILE_MASK, -1,
    HG_PROJECTILE_IS_TRANSCENDENT, 1,
    HG_PROJECTILE_ENEMY_BEHAVIOR, 1,
    HG_PROJECTILE_GROUND_BEHAVIOR, 1,
    HG_PROJECTILE_WALL_BEHAVIOR, 1,
    HG_PROJECTILE_UNBASHABLE, 1,
    HG_PROJECTILE_DOES_NOT_REFLECT, 1,
    HG_PROJECTILE_PARRY_STUN, 1,
    HG_EXTENDED_PARRY_STUN, 1,
    HG_PROJECTILE_PLASMA_SAFE, 1,
)

make_hitbox(42, 3,
    HG_HITBOX_TYPE, 2,
    HG_LIFETIME, 4,
    
    // These are used by and relative to the article.
    HG_WINDOW_CREATION_FRAME, 5,
    HG_HITBOX_X, -16,
    HG_HITBOX_Y, -36,
    
    HG_WIDTH, 40,
    HG_HEIGHT, 70,
    HG_PRIORITY, 2,
    HG_DAMAGE, 6,
    HG_ANGLE, 45,
    HG_ANGLE_FLIPPER, 7, // Towards desperado
    HG_BASE_KNOCKBACK, 8,
    HG_KNOCKBACK_SCALING, .3,
    HG_HITSTUN_MULTIPLIER, .7,

    HG_BASE_HITPAUSE, 7,
    HG_HITPAUSE_SCALING, .7,

    HG_HIT_SFX, asset_get("sfx_blow_medium3"),
    
    HG_PROJECTILE_SPRITE, sprite_get("null"),
    HG_PROJECTILE_DESTROY_EFFECT, hfx_null,
    HG_PROJECTILE_MASK, -1,
    HG_PROJECTILE_IS_TRANSCENDENT, 1,
    HG_PROJECTILE_ENEMY_BEHAVIOR, 1,
    HG_PROJECTILE_GROUND_BEHAVIOR, 1,
    HG_PROJECTILE_WALL_BEHAVIOR, 1,
    HG_PROJECTILE_UNBASHABLE, 1,
    HG_PROJECTILE_DOES_NOT_REFLECT, 1,
    HG_PROJECTILE_PARRY_STUN, 1,
    HG_EXTENDED_PARRY_STUN, 1,
    HG_PROJECTILE_PLASMA_SAFE, 1,
)

//#endregion

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