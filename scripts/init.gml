// init.gml


//...And so he left, with his pyrrhic plunder.
//Desperado, the Remnant of Ash

//lore:
//Desperado was one of the first mechanics, working with another man, using gunpowder and ash to create what are known today as guns. At the front of the gold rush, he was there, innovating and pushing his craft.
//After a particularly heavy dust storm seperated the small mining town he had founded from the rest of the world, the small populous was unable to sustain themselves. 
//In a senseless act of greed to try and leave the dust storm, he stole everything from his partner, who retaliated, shooting him and going on to be credited as the creator of the firearm in its use in modern day Aether - though its still shunned by the government, so its uses are limited, being sold in black markets and under the table deals.
//As a restless and vengeful spirit, Desperado is still said to roam the aimless stretches of Aether, haunting and hunting people who follow the path he did.

//Desperado is a powerful Zoner who plays keepaway - His main goal is to reload his gun every stock, which has up to 6 bullets in it, by using Down Special, or a few unique normals. 
//His gun is the first one ever created- It's incredbily powerful, but volatile. By adding bullets to the chamber, it increases the heat of the gun, and Desperado, giving him a damage buff for every bullet inside.
//Bullets give him up to 75% more damage and give him access to a few new attacks: (Ftilt?) (fspec)?
//You can expend bullets by using F-Strong or (maybe an aerial rekka?). F-Strong is his most powerful one, a large shrapnel explosion, but requires a bullet to use, so bec areful.
//N-Special is Desperate Measures: A strong gunshot attack that expends all his bullets in a hammer fan. This move gets incredibly strong with higher bullet counts, becoming the strongest projectile tool in the game with all 6.
//However, it also uses every bullet in your chamber, forcing you to reload everything again in order to use the attack. 

//As for the rest of his kit, hes slow, large, and slightly floaty, meaning he has a pretty big weakness in his disadvantage. His damage also starts out quite low, needing bullets to ramp it up. 
//However, to make up for this, he has very large, powerful disjoints, quicker startup on key moves than you'd expect, and a myriad of tools to combo into Desperate Measures, making getting hit with 5 or 6 bullets extremely scary for the enemy.

//Down Special - Reload 
//Desperado loads a bullet into his chamber, increasing the heat of the weapon, and his damage. You can have up to 6 bullets in the chamber at a time, for up to a 75% damage multiplier. This also affects certain other moves.

//Neutral Special - Desperate Measures 
//Desperado shoots every bullet in his chamber in a hammer fan. This move gets sequentially stronger with every bullet shot, and at full bullets, becomes the strongest projectile in the game. Once used, you need to reload your bullets.

//Forward Special - maybe he sets upa smoke clone
// after a second it sends writhing tendrils towards the opponent if they dont hit it 
//idk yet :(

//Up Special - Deadshot
//Desperado uses a whip-like- attack and swings in front and above him. its a quick attack with a sweetspot on the end that makes as an excellent finisher.
//If the whip touches a wall, he will zoop towards it, giving him an upwards boost and letting him walljump.
//Otherwise, he'll get a small boost, and doesn't go into pratfall.


//todo

//finish moveset
//finish specials
//put in extra stuff (portrait preview)
//trailer


// Character-specific indices
AG_WINDOW_SKULL_GRABBOX_X = 41; // Reserved slots for uspecial
AG_WINDOW_SKULL_GRABBOX_Y = 42;
AG_WINDOW_SKULL_GRABBOX_W = 43;
AG_WINDOW_SKULL_GRABBOX_H = 44;
AG_MUNO_ATTACK_NAME = 70; // Woodcock compat, can be freely changed
AG_MUNO_ATTACK_MISC = 71

// Character-specific assets
num_bullets = 0;                        // 0-6
bullet_mult = 0.125;                    // multiplier per bullet. Constant value
u_mult_damage_buffer = 0;               // see also: other_init.gml

reload_anim_timer = 999;

nametag_white_flash = 0;
nametag_flame_alpha = 0;

sparkle_list = ds_list_create();        // particle list. implementation is taken from aur, hence the name
nspec_shot_list = ds_list_create();     // similar particle manager for nspecial shots.

dairs_used = 0;                         // dairs used per airtime

signpost_obj = noone;                   // taunt

// Training mode assets
draw_skull_grabbox = 0;


//Article
head_obj = instance_create(x, y, "obj_article1");

anim_list = [
    "idle",
    "desp_hurt",
    "uphurt",
    "downhurt",
    "bighurt",
    "bouncehurt",
    "spinhurt",
    "hurtground",
    "desp_hitstun_hurt",
    "crouch",
    "desp_crouch_hurt",
    "hurt",
    "walk",
    "walkturn",
    "dash",
    "dashstart",
    "dashstop",
    "dashturn",
    "jumpstart",
    "jump",
    "doublejump",
    //"jab",
    "fair",
    //"bair",
    "roll_forward",
    "roll_backward",
    //"uspecial",
    "dtilt",
    "airdodge_forward",
    "airdodge_up",
    "airdodge_upforward",
    "airdodge_forward",
    "airdodge_downforward",
    "airdodge_down",
    "airdodge_downback",
    "airdodge_back",
    "airdodge_upback",
    "airdodge",
    "dattack",
    "waveland",
    "tech",
    "walljump",
    "landinglag",
    "nair",
    "ustrong",
    "parry",
    "dspecial",
   // "utilt",
    "ftilt",
   // "uair",
    //"dair",
    "pratfall",
    "landinglag",
    "land",
    "nspecial",
    //"taunt",
    //"taunt_2",
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
prat_land_time = 15 // 3 – 24. The number of frames in your prat land state
wave_land_time = 12 // 6 – 12 usually 8. The number of frames your waveland state lasts
wave_land_adj = 1.2 // 1.2 – 1.5. The multiplier to your initial hsp when wavelanding. Usually greater than 1
wave_friction = 0.15 // 0 – .15. Grounded deceleration when wavelanding

// Air Movement
air_dodge_speed = 7.5 // 7.5 – 8	The speed during airdodge’s movement

air_accel = .5 // .2 – .4. The hsp acceleration applied when you hold left or right in a normal aerial state
prat_fall_accel = .85 // .4 – 1.5.	A multiplier to your normal horizontal aerial acceleration: 1 = normal 0 = no acceleration
air_friction = .02 // .02 – .07. Natural deceleration applied while in the air. Also applies while in hitstun, increasing survivability

max_fall = 9 // 8 – 11. The maximum vsp you can accelerate to while falling normally
fast_fall = 11.5 // 11 – 16. The vsp applied when fastfalling
gravity_speed = .4// .3 – .6. The gravitational acceleration applied in non-hitstun aerial states
hitstun_grav = .4// .45 – .525. The gravitational acceleration applied in hitstun. Changes to this have large consequences to your character's survivibility

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
double_jump_time = 40 // 24 – 40. The number of frames to play the double jump animation. Most characters have a value of 32 so that the double jump animation transitions into the falling portion of the normal jump animation 

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
has_intro = true; //change to false if you don't have one/don't want it active

// VFX
hfx_bone_large = hit_fx_create(sprite_get("vfx_bone_large"), 28)
hfx_null = hit_fx_create(sprite_get("null"), 0)
vfx_flash = hit_fx_create(sprite_get("nspecflash"), 16)
vfx_bullseye = hit_fx_create(sprite_get("vfx_1"), 32)
vfx_bullseye_small = hit_fx_create(sprite_get("vfx_2"), 23)
vfx_fstrong_blast = hit_fx_create(sprite_get("fstrongblast"), 12)
//Sprites
// spr_nspecial_proj = sprite_get("nspecial_proj")


// SFX
// sfx_example = sound_get("example") // sounds/example.ogg

// VFX
// vfx_example = hit_fx_create(spr_example, 54)


// Visual offsets for when you're in Ranno's bubble
bubble_x = 0
bubble_y = 8