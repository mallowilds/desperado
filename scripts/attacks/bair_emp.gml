// bair_emp.gml

make_attack(AT_EXTRA_1,
  AG_CATEGORY, 1,
  AG_SPRITE, sprite_get("bair"),
  AG_HAS_LANDING_LAG, 1,
  AG_LANDING_LAG, 8,
  AG_NUM_WINDOWS, 3,
  AG_HURTBOX_SPRITE, sprite_get("bair_hurt"))

make_window(AT_EXTRA_1, 1,
  AG_WINDOW_LENGTH, 12,
  AG_WINDOW_ANIM_FRAMES, 1,
  AG_WINDOW_ANIM_FRAME_START, 5,
  AG_WINDOW_VSPEED, -1,
  AG_WINDOW_HAS_SFX, 1,
  AG_WINDOW_SFX, asset_get("sfx_swipe_heavy1"),
  AG_WINDOW_SFX_FRAME, 11)

make_window(AT_EXTRA_1, 2,
  AG_WINDOW_LENGTH, 3,
  AG_WINDOW_ANIM_FRAMES, 1,
  AG_WINDOW_ANIM_FRAME_START, 6)

make_window(AT_EXTRA_1, 3,
  AG_WINDOW_LENGTH, 21,
  AG_WINDOW_ANIM_FRAMES, 3,
  AG_WINDOW_ANIM_FRAME_START, 7,
  AG_WINDOW_HAS_WHIFFLAG, 4)

set_num_hitboxes(AT_EXTRA_1, 3)

make_hitbox(AT_EXTRA_1, 1,
  HG_HITBOX_TYPE, 1,
  HG_WINDOW, 2,
  HG_LIFETIME, 3,

  HG_WIDTH, 58,
  HG_HEIGHT, 54,
  HG_HITBOX_Y, -8,
  HG_HITBOX_X, -64,


  HG_PRIORITY, 1,
  HG_DAMAGE, 7,
  HG_ANGLE, 140,
  //HG_ANGLE_FLIPPER, 5,
  HG_BASE_KNOCKBACK, 7,
  HG_KNOCKBACK_SCALING, .6,

  HG_BASE_HITPAUSE, 8,
  HG_HITPAUSE_SCALING, .8,

  HG_HIT_SFX, asset_get("sfx_blow_heavy1"),
  HG_VISUAL_EFFECT, 304
  
)

make_hitbox(AT_EXTRA_1, 2,
  HG_HITBOX_TYPE, 1,
  HG_WINDOW, 2,
  HG_LIFETIME, 3,

  HG_WIDTH, 90,
  HG_HEIGHT, 60,
  HG_HITBOX_Y, -20,
  HG_HITBOX_X, -30,


  HG_PRIORITY, 1,
  HG_DAMAGE, 7,
  HG_ANGLE, 140,
 // HG_ANGLE_FLIPPER, 5,
  HG_BASE_KNOCKBACK, 7,
  HG_KNOCKBACK_SCALING, .6,

  HG_BASE_HITPAUSE, 8,
  HG_HITPAUSE_SCALING, .8,

  HG_HIT_SFX, asset_get("sfx_blow_heavy1"),
  HG_VISUAL_EFFECT, 304
  
)

make_hitbox(AT_EXTRA_1, 3,
  HG_HITBOX_TYPE, 1,
  HG_WINDOW, 2,
  HG_LIFETIME, 3,

  HG_WIDTH, 12,
  HG_HEIGHT, 12,
  HG_HITBOX_Y, -2,
  HG_HITBOX_X, -84,


  HG_PRIORITY, 2,
  HG_DAMAGE, 9,
  HG_ANGLE, 140,
  //HG_ANGLE_FLIPPER, 5,
  HG_BASE_KNOCKBACK, 8,
  HG_KNOCKBACK_SCALING, .8,

  HG_BASE_HITPAUSE, 9,
  HG_HITPAUSE_SCALING, 1,

  HG_HIT_SFX, asset_get("sfx_blow_heavy2"),
  HG_VISUAL_EFFECT, 304
  
)

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define make_attack // Version 0
    // make_attack(_attack_name, (value_name, value)... )
    // Sets attack values for the given attack.
    // e.g. make_attack(AT_EXTRA_1,
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
    // e.g.make_window(AT_EXTRA_1, 1,
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
    // e.g. make_hitbox(AT_EXTRA_1, 1,
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