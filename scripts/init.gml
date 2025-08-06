// init.gml

// Character-specific indices
AG_WINDOW_SKULL_GRABBOX_X = 41; // Reserved slots for uspecial
AG_WINDOW_SKULL_GRABBOX_Y = 42;
AG_WINDOW_SKULL_GRABBOX_W = 43;
AG_WINDOW_SKULL_GRABBOX_H = 44;
AG_MUNO_ATTACK_NAME = 70; // Woodcock compat, can be freely changed
AG_MUNO_ATTACK_MISC = 71;
HG_MUNO_HITBOX_MISC_ADD = 72;
AT_TAUNT_GEN = 49; // Unfortunately needs to be updated manually in attack_update if changed

// Character-specific assets
num_bullets = 0;                        // 0-6
bullet_mult = 0.125;                    // multiplier per bullet. Constant value
u_mult_damage_buffer = 0;               // see also: other_init.gml

reload_anim_state = 0;                  // See update.gml
reload_anim_timer = 0;
reload_anim_frame = 0;

switch get_player_color(player) {
    case 8:
        hud_bullet_color_slot = 6;
        break;
    case 3:
        hud_bullet_color_slot = 1;
        break;
    case 5:
    case 12:
        hud_bullet_color_slot = 3;
    default:
        hud_bullet_color_slot = 5;
}

nametag_white_flash = 0;
nametag_flame_alpha = 0;

sparkle_list = ds_list_create();        // particle list. implementation is taken from aur, hence the name
nspec_shot_list = ds_list_create();     // similar particle manager for nspecial shots.
fspec_held = false;

signpost_obj = noone;                   // taunt

spin_sfx_instance = noone;
bair_sfx_instance = noone;
whisper_sfx_instance = noone;

// Training mode assets
draw_skull_grabbox = 0;

// Special alt detection
// (note: synced_var was set to player color in css_update for desync prevention)
is_seasonal = (get_synced_var(player) == 12);
seasonal_type = get_match_setting(SET_SEASON);
display_seasonal = is_seasonal;
vfx_seasonal = [noone,
                hit_fx_create(sprite_get("idle_holiday1_die"), 25),
                hit_fx_create(sprite_get("idle_holiday2_die"), 15),
                noone,
                hit_fx_create(sprite_get("idle_holiday4_die"), 20),
                ];

is_genesis = (get_synced_var(player) == 13);
genesis_spawn_player_id = self; // default to self (for training mode)
gen_image_index = 0;

//Article
head_obj = instance_create(x, y, "obj_article1");

anim_list = [
    "airdodge_backward",
    "airdodge_back",
    "airdodge_downforward",
    "airdodge_down",
    "airdodge_forward",
    "airdodge_upforward",
    "airdodge_up",
    "airdodge",
    "bair",
    "bighurt",
    "bouncehurt",
    "crouch",
    "dair",
    "dashstart",
    "dashstop",
    "dashturn",
    "dash",
    "doublejump",
    "dspecial",
    "dstrong",
    "dtilt",
    "fair",
    "fstrong_nul",
    "fstrong",
    "ftilt_emp",
    "ftilt",
    "hurtground",
    "hurt",
    "idle",
    "jab",
    "jumpstart",
    "jump",
    "landinglag",
    "land",
    "nair",
    "nspecial",
    "parry",
    "pratfall",
    "pratland",
    "roll_backward",
    "roll_forward",
    "spinhurt",
    "taunt_2",
    "taunt",
    "tech",
    "uair",
    "uphurt",
    "uspecial",
    "utilt",
    "walkturn",
    "walk",
    "walljump",
    "waveland",
    ];


// Tampered with in update.gml
char_height = 70 // 36 – 74. Purely aesthetic. Used for centering things on the character, placing the overhead HUD, etc


//Lightweight, slightly lower than average friction. Falls slowly.
knockback_adj = 1.10 //.9 – 1.2. The multiplier to knockback dealt to you: 1 = default value higher values = lighter character lower values = heavier character

// MOVEMENT

// Ground Movement
walk_speed = 3.25 // 3 - 4.5. The maximum speed you can achieve while walking, in pixels per frame
walk_accel = 0.35 // .2 – .5. The speed gained per frame while walking
walk_turn_time = 6 // 6 for all characters. The number of frames it takes to turn around

initial_dash_time = 8 // 8 – 16. The number of frames in your initial dash
initial_dash_speed = 5 // 4 – 11. The speed of your initial dash in pixels per frame
dash_speed = 5.5 // 4.75 – 9. The speed of your run in pixels per frame
dash_turn_time = 10 // 8 – 20. The number of frames it takes to turn while running
dash_turn_accel = 1.3 // .1 – 2. The acceleration applied when turning while running
dash_stop_time = 4 // 4 – 6. The number of frames it takes to stop while running
dash_stop_percent = .35 // .25 – .5. the value to multiply your hsp by when going into idle from dash or dashstop

ground_friction = .4 // .3 – 1. Natural deceleration while on the ground
moonwalk_accel = 1.4 // 1.2 – 1.4.	The acceleration to apply while moonwalking

roll_forward_max = 9 // 9 – 11. The speed of your forward roll
roll_backward_max = 9 // 9 – 11. The speed of your backward roll

techroll_speed = 10 // 8 – 11. The speed during techroll’s movement

// Landing
land_time = 4 // 4 – 6. The number of frames in your normal landing state
prat_land_time = 20 // 3 – 24. The number of frames in your prat land state
wave_land_time = 12 // 6 – 12 usually 8. The number of frames your waveland state lasts
wave_land_adj = 1.2 // 1.2 – 1.5. The multiplier to your initial hsp when wavelanding. Usually greater than 1
wave_friction = 0.15 // 0 – .15. Grounded deceleration when wavelanding

// Air Movement
air_dodge_speed = 7.5 // 7.5 – 8	The speed during airdodge’s movement

air_accel = .5 // .2 – .4. The hsp acceleration applied when you hold left or right in a normal aerial state
prat_fall_accel = .5 // .4 – 1.5.	A multiplier to your normal horizontal aerial acceleration: 1 = normal 0 = no acceleration
air_friction = .02 // .02 – .07. Natural deceleration applied while in the air. Also applies while in hitstun, increasing survivability

max_fall = 9 // 8 – 11. The maximum vsp you can accelerate to while falling normally
fast_fall = 11.5 // 11 – 16. The vsp applied when fastfalling
gravity_speed = .4// .3 – .6. The gravitational acceleration applied in non-hitstun aerial states
hitstun_grav = .48// .45 – .525. The gravitational acceleration applied in hitstun. Changes to this have large consequences to your character's survivibility

// Jumping
max_djumps = 1 // The max number of double jumps you can use.

short_hop_speed = 6 // 4 – 7.4	The vsp applied when shorthopping
jump_speed = 9 //7.6 – 12. The vsp applied when fullhopping
djump_speed = 10 // 8 – 12 (-1 for Absa). The vsp applied when double jumping
djump_accel = 0 // 0 (-1 for Absa). Requires djump_accel_end_time to be set
djump_accel_end_time = 0 // The duration that djump_accel is applied.

leave_ground_max = 7 // 4 – 8. The maximum hsp you can have when you go from grounded to aerial without jumping
max_jump_hsp = 6.5 // 4 – 8. The maximum hsp you can have when jumping from the ground
air_max_speed = 5 //3 – 7. The maximum hsp you can accelerate to when in a normal aerial state

jump_start_time = 5 // 5 for all characters. The number of frames of jumpsquat minus one
jump_change = 3 // 3 for all characters. The hsp applied if left or right is held when jumping. Will not slow you down if you’re already going faster. When reversing your momentum with a double jump, this is the maximum hsp you can have


// Wall Jumping
walljump_hsp = 6 // 4 – 7. The horizontal speed to apply while walljumping, in pixels per frame
walljump_vsp = 9 // 7 – 10. The vertical speed to apply while walljumping, in pixels per frame
walljump_time = 24 // 18 – 32.	The number of frames the walljump state takes. Normally 32, but some characters have shorter values


// ANIMATION

// Animation Speeds
idle_anim_speed = .1 //The speed of your idle animation in anim frames per gameplay frame
walk_anim_speed = .125 //The speed of your walk animation in anim frames per gameplay frame
dash_anim_speed = .2 //The speed of your dash animation in anim frames per gameplay frame
pratfall_anim_speed = .25 //The speed of your pratfall animation in anim frames per gameplay frame
crouch_anim_speed = .1 //	The speed of your (held) crouch animation in anim frames per gameplay frame

// Jump
double_jump_time = 32 // 24 – 40. The number of frames to play the double jump animation. Most characters have a value of 32 so that the double jump animation transitions into the falling portion of the normal jump animation 

// Crouch Animation Frames
crouch_startup_frames = 4 // The number of animation frames during crouch’s startup
crouch_active_frames = 2 // The number of animation frames during crouch's active frameslan
crouch_recovery_frames = 3 // The number of animation frames during crouch’s recovery
// Crouch Animation Start/End Customization by @SupersonicNK
crouch_start_time = 16; // time in frames it takes for crouch start to stop.
crouch_end_time = 18; // time in frames it takes for crouch stop to stop. interruptable.

// Custom Crouch Internal Variables (managed by the code)
ccrouch_playing = false; // whether the custom crouch animation is playing
ccrouch_phase = 0; // 0 = start, 1 = loop, 2 = uncrouch
ccrouch_timer = 0; // timer for the crouch anim
ccrouch_percent = 0; // 0-1, used to calculate what frame to use when rapidly crouching and uncrouching
// Parry Animation Frames
dodge_startup_frames = 1 // Number of animation frames during parry’s startup. Usually just 1
dodge_active_frames = 2 //	Number of animation frames during parry’s active frames
dodge_recovery_frames = 4 // Number of animation frames during parry’s recovery frames

// Tech Animation Frames
tech_active_frames = 3 // The number of animation frames during tech in place’s invincibility
tech_recovery_frames = 2 // The number of animation frames during tech in place’s recovery

// Tech Roll Animation Frames
techroll_startup_frames = 1 // The number of animation frames during techroll’s startup
techroll_active_frames = 3 // The number of animation frames during techroll’s movement
techroll_recovery_frames = 2 // The number of animation frames during techroll’s recovery

// Airdodge Animation Frames
air_dodge_startup_frames = 2 // The number of animation frames during techroll’s startup
air_dodge_active_frames = 1 // The number of animation frames during techroll’s movement
air_dodge_recovery_frames = 2 // The number of animation frames during techroll’s recovery

// Roll Animation Frames
roll_forward_startup_frames = 1 // The number of animation frames during roll forward’s startup
roll_forward_active_frames = 3 // The number of animation frames during roll forward’s movement
roll_forward_recovery_frames = 2 // The number of animation frames during roll forward’s recovery
roll_back_startup_frames = 1 // The number of animation frames during roll backward’s startup
roll_back_active_frames = 3 // The number of animation frames during roll backward’s movement
roll_back_recovery_frames = 2 // The number of animation frames during roll backward’s recovery

adown = 0

// SPRITES
// my_spr = sprite_get("my_sprite") // Loads from sprites/my_sprite_stripX.png
// Hurtbox Sprites
hurtbox_spr = sprite_get("desp_hurt")
crouchbox_spr = sprite_get("desp_crouch_hurt")
air_hurtbox_spr = -1  // -1 means use hurtbox_spr
hitstun_hurtbox_spr = sprite_get("desp_hitstun_hurt")  // -1 means use hurtbox_spr

// SOUNDS
// my_sfx = sound_get("my_sfx") // Loads from sounds/my_sfx.ogg
// Movement Sounds
wavedashsfx = sound_get("desp_wavedash")
adodge = asset_get("sfx_quick_dodge")

land_sound = asset_get("sfx_land_med")
landing_lag_sound = asset_get("sfx_land")
waveland_sound = 0
jump_sound = asset_get("sfx_jumpground")
djump_sound = asset_get("sfx_jumpair")
air_dodge_sound = 0;

//custom intro
AT_INTRO = 2; //the attack index the intro uses, 2 doesn't overwrite any other attack

// VFX
vfx_bone_large = hit_fx_create(sprite_get("vfx_bone_large"), 30);
vfx_smog = hit_fx_create(sprite_get("vfx_smog_1"), 20);
vfx_null = hit_fx_create(sprite_get("null"), 0);
vfx_flash = hit_fx_create(sprite_get("nspecflash"), 16);
vfx_bullseye = hit_fx_create(sprite_get("vfx_1"), 32);
vfx_bullseye_small = hit_fx_create(sprite_get("vfx_2"), 23);
vfx_fstrong_blast = hit_fx_create(sprite_get("fstrongblast"), 12);
vfx_wisp_end = hit_fx_create(sprite_get("wispend"), 9);


//other
set_victory_theme(sound_get("victory"))
set_victory_bg(CH_FORSBURN)

set_hit_particle_sprite(1, sprite_get("skull_hpart"));

hue_offset=160;
hue_speed=1; //change this to change the speed of the hueshift
hue_increasing = 1

//Sprites
// spr_nspecial_proj = sprite_get("nspecial_proj")


// SFX
// sfx_example = sound_get("example") // sounds/example.ogg

// VFX
// vfx_example = hit_fx_create(spr_example, 54)


// Visual offsets for when you're in Ranno's bubble
bubble_x = 0
bubble_y = 8