
// article1_update - runs every frame the article exists
// Minor physics objects

/*STATE LIST

- Default (-1): Failed initialization

BULLET CASING
- 00: Initialization
- 01: Pre-bounce
- 02: Post-bounce

TAUNT SIGNPOST
- 10: Initialization
- 11: Idle
- 12: Sway left
- 13: Sway right
- 14: Death

*/

switch state {
    
    
    //#region Bullet casing
    case 00:
        sprite_index = sprite_get("null");
        mask_index = sprite_get("bullet_mask");
        depth = player_id.depth-1;
        proj_angle = random_func_2(3, 360, false);
        old_vsp = vsp;
        old_hsp = hsp;
        // HSP and VSP are set by spawning object
        state = 01;
        break;
        
    case 01:
        if (!free) {
            sound_play(sound_get("desp_cointoss"), false, noone, 0.5, 0.75+(0.35*random_func(12, 1, false)))
            vsp = -3;
            can_be_grounded = false;
            ignores_walls = true;
            state = 02;
        }
        if (hit_wall) {
            can_be_grounded = false;
            ignores_walls = true;
            state = 02;
            hsp = old_hsp;
        }
        
    case 02:
        if (hsp > 0) hsp -= 0.01;
        else if (hsp < 0) hsp += 0.01;
        if (vsp < 9) vsp += 0.35;
        proj_angle += 5*spr_dir;
        
        if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
            instance_destroy();
            exit;
        }
        
        old_vsp = vsp;
        old_hsp = hsp;
        break;
        
    //#endregion
    
    
    
    //#region Taunt Signpost
    // Init
    case 10:
        sprite_index = sprite_get("sign");
        mask_index = sprite_get("sign_mask");
        y += 1 // honestly idk
        
        dasher_in_range = [noone, 0, 0, 0, 0];
        
        //get highest-damage opponent icon
        top_damage = -1;
        icon_spr = get_char_info(player, INFO_ICON) // default to desp if things fail
        icon_image = 0;
        icon_scale = 2;
        with oPlayer {
            if (player == other.player || get_player_team(player) == get_player_team(other.player) || get_player_damage(player) <= other.top_damage) continue;
            other.top_damage = get_player_damage(player);
            if (!custom) with other {
                icon_spr = sprite_get("bc_icons");
                icon_image = other.url;
                icon_scale = 1;
            }
            else {
                other.icon_spr = get_char_info(player, INFO_ICON)
                other.icon_image = 0;
                other.icon_scale = 2;
            }
        }
        
        state = 11;
        state_timer = 0;
        break;
    
    // Idle
    case 11:
        sprite_index = sprite_get("sign");
        image_index = 0;
        
        // Detect dashes
        var dash_dir = signpost_detect_dashes();
        if (dash_dir != 0) {
            sprite_index = sprite_get((dash_dir*spr_dir == -1) ? "sign_move_l" : "sign_move_r");
            state = (dash_dir*spr_dir == -1 ? 12 : 13);
            state_timer = 0;
            sound_play(asset_get("sfx_holy_grass"), false, noone, 0.7, 0.75+(0.35*random_func(12, 1, false)));
        }
        
        // Detect hitboxes
        if (signpost_detect_hitboxes()) {
            state = 14;
            state_timer = 0;
        }
        
        // Detect airborne-ness
        if (free) {
            state = 14;
            state_timer = 0;
        }
        break;
    
    // Sway left
    case 12:
        sprite_index = sprite_get("sign_move_l");
        image_index = state_timer / 5;
        if (image_index >= 4) {
            sprite_index = sprite_get("sign");
            state = 11;
            state_timer = 0;
        }
        
        // Update dash tracker
        signpost_detect_dashes();
        
        // Detect hitboxes
        if (signpost_detect_hitboxes()) {
            state = 14;
            state_timer = 0;
        }
        
        // Detect airborne-ness
        if (free) {
            state = 14;
            state_timer = 0;
        }
        
        break;
    
    // Sway right
    case 13:
        sprite_index = sprite_get("sign_move_r");
        image_index = state_timer / 5;
        if (image_index >= 4) {
            sprite_index = sprite_get("sign")
            state = 11;
            state_timer = 0;
        }
        
        // Update dash tracker
        signpost_detect_dashes();
        
        // Detect hitboxes
        if (signpost_detect_hitboxes()) {
            state = 14;
            state_timer = 0;
        }
        
        // Detect airborne-ness
        if (free) {
            state = 14;
            state_timer = 0;
        }
        
        break;
    
    // Death
    case 14:
        sprite_index = sprite_get("sign_die");
        image_index = 1+(state_timer / 7);
        if (image_index >= 5) {
            if (player_id.signpost_obj == self) player_id.signpost_obj = noone;
            instance_destroy();
            exit;
        }
        break;
    
    
    //#endregion
    
    
    //#region Failed initialization
    default:
        print_debug("Error: article 3 was not properly initialized")
        instance_destroy();
        exit;
    //#endregion
    
}


// Make time progress
state_timer++;



#define signpost_detect_dashes()
    // Returns 0 for none detected, -1 for left dash, 1 for right dash
    var out = 0;
    with player_id.object_index {
        var dashing = hsp != 0 && (state == PS_DASH_START || state == PS_DASH || state == PS_WAVELAND) && place_meeting(x, y, other);
        var dash_dir = dashing ? (hsp < 0 ? -1 : 1) : 0;
        if (dash_dir != other.dasher_in_range[player]) {
            other.dasher_in_range[player] = dash_dir;
            if (dash_dir != 0) out = dash_dir;
        }
    }
    return out;

#define signpost_detect_hitboxes()
    var hbox = noone;
    with pHitBox {
        if (place_meeting(x, y, other) && (hit_priority > 0) && player != other.player) {
            if (hbox == noone || type == 1 && hbox.type == 2 || hit_priority > hbox.hit_priority) {
                hbox = self;
            }
        }
    }
    
    if (hbox != noone) {
        hitstop = floor(hbox.hitpause + hbox.extra_hitpause);
        if (hbox.type == 1) with (hbox.player_id) {
            if (!hitpause) {
                old_hsp = hsp;
                old_vsp = vsp;
            }
            hitpause = true;
            has_hit = true; // mixed feelings but also letting kragg jump-cancel off of the signpost is Really Funny so
            if (hitstop < hbox.hitpause) {
                hitstop = hbox.hitpause;
                hitstop_full = hbox.hitpause;
            }
        }
        sound_play(hbox.sound_effect);
        spawn_hit_fx((x+hbox.x)/2+(hbox.spr_dir*hbox.hit_effect_x), (y-30+hbox.y)/2+(hbox.hit_effect_y), HFX_SYL_WOOD_SMALL);
        return true;
    }
    return false;