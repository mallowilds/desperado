
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
- 15: Burn away

TAUNT GUNSHOT
- 20: Initialization
- 21: Moving

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
    
    
    
    //#region Taunt signpost
    // Init
    case 10:
        sprite_index = sprite_get("sign");
        mask_index = sprite_get("sign_ground_mask");
        vsp = 3;
        
        spr_dir = 1;
        
        dasher_in_range = [noone, 0, 0, 0, 0];
        
        //get highest-damage opponent icon
        top_damage = -1;
        wanted_target = player_id;
        icon_spr = get_char_info(player, INFO_ICON) // default to desp if things fail
        icon_image = 0;
        icon_scale = 2;
        with oPlayer {
            if (player == other.player || get_player_team(player) == get_player_team(other.player) || get_player_damage(player) <= other.top_damage) continue;
            other.top_damage = get_player_damage(player);
            if (!custom) with other {
                wanted_target = other;
                icon_spr = sprite_get("bc_icons");
                icon_image = other.url;
                icon_scale = 1;
            }
            else {
                other.wanted_target = self;
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
        
        else if (wanted_target.state == PS_RESPAWN) {
            state = 15;
            state_timer = 0;
        }
        
        // Apply gravity
        if (free) vsp += 0.4;
        if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
            instance_destroy();
            exit;
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
        
        else if (wanted_target.state == PS_RESPAWN) {
            state = 15;
            state_timer = 0;
        }
        
        // Apply gravity
        vsp += 0.4;
        if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
            instance_destroy();
            exit;
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
        
        else if (wanted_target.state == PS_RESPAWN) {
            state = 15;
            state_timer = 0;
        }
        
        // Apply gravity
        vsp += 0.4;
        if (y > get_stage_data(SD_BOTTOM_BLASTZONE_Y)) {
            instance_destroy();
            exit;
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
    
    // Burn away
    case 15:
        sprite_index = sprite_get("sign_burn");
        image_index = state_timer / 5;
        if (image_index >= 17) {
            if (player_id.signpost_obj == self) player_id.signpost_obj = noone;
            instance_destroy();
            exit;
        }
        
        if (state_timer == 5) sound_play(sound_get("desp_scratch"), 0, noone, 1, 0.9);
        else if (state_timer == 20) sound_play(sound_get("desp_scratch"), 0, noone, 1, 1);
        else if (state_timer == 40) sound_play(asset_get("sfx_zetter_fireball_fire"), 0, noone, .7, .9)
        
        break;
    
    //#endregion
    
    
    
    //#region Taunt gunshot
    case 20:
        sprite_index = sprite_get("null"); // rotation-reliant - see article3post_draw.gml
        can_be_grounded = false;
        ignores_walls = true;
        signpost_obj = player_id.signpost_obj;
        
        if (instance_exists(signpost_obj) && signpost_obj.state != 14) {

            if (x*spr_dir <= signpost_obj.x*spr_dir) { // i.e. signpost is in front
                if (point_distance(x, y, signpost_obj.x, signpost_obj.y-50) < 160) {
                    signpost_obj.state_timer = 0;
                    signpost_obj.state = 14;
                    sound_play(asset_get("sfx_syl_ustrong_part3"))
                    sound_play(asset_get("sfx_ell_drill_stab"))
                    spawn_hit_fx(signpost_obj.x, signpost_obj.y-50, HFX_SYL_WOOD_SMALL);
                    instance_destroy();
                    exit;
                }
                move_angle = point_direction(x, y, signpost_obj.x, signpost_obj.y-50);
                screen_wrap = false;
            }
            else {
                if (point_distance(x, y, signpost_obj.x, signpost_obj.y-50) < 30) {
                    signpost_obj.state_timer = 0;
                    signpost_obj.state = 14;
                    sound_play(asset_get("sfx_syl_ustrong_part3"))
                    sound_play(asset_get("sfx_ell_drill_stab"))
                    spawn_hit_fx(signpost_obj.x, signpost_obj.y-50, HFX_SYL_WOOD_SMALL);
                    instance_destroy();
                    exit;
                }
                var sim_x_distance = spr_dir * (view_get_wview() - abs(x-signpost_obj.x));
                move_angle = point_direction(0, y, sim_x_distance, signpost_obj.y-50);
                screen_wrap = true;
            }
            
        }
        else {
            move_angle = 90 - (90*spr_dir);
            screen_wrap = false;
        }
        
        state = 21;
        state_timer = 0;
        break;
    
    case 21:
        
        hsp = lengthdir_x(120, move_angle);
        vsp = lengthdir_y(120, move_angle);
        
        if (screen_wrap) {
            if (spr_dir == -1 && x+hsp < view_get_xview()) { // WARN: Possible Desync. Consider using get_instance_x(asset_get("camera_obj")).
                x += view_get_wview();
                screen_wrap = false;
            }
            else if (spr_dir == 1 && x+hsp > view_get_xview()+view_get_wview()) { // WARN: Possible Desync. Consider using get_instance_x(asset_get("camera_obj")).
                x -= view_get_wview();
                screen_wrap = false;
            }
        }
        
        if (instance_exists(signpost_obj)) {
            var old_mask = signpost_obj.mask_index;
            signpost_obj.mask_index = sprite_get("sign_mask");
            if (signpost_obj.state != 14 && collision_line(x, y, x+lengthdir_x(160, move_angle), y+lengthdir_y(160, move_angle), signpost_obj, false, false)) {
                signpost_obj.state = 14;
                signpost_obj.state_timer = 0;
                sound_play(asset_get("sfx_syl_ustrong_part3"))
                sound_play(asset_get("sfx_ell_drill_stab"))
                spawn_hit_fx(signpost_obj.x, signpost_obj.y-50, HFX_SYL_WOOD_SMALL);
                instance_destroy();
                exit;
            }
            signpost_obj.mask_index = old_mask;
        }
        
        
        if (state_timer > 60) {
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

    var old_mask = mask_index;
    mask_index = sprite_get("sign_mask");

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
        spawn_hit_fx((x+hbox.x)/2+(hbox.spr_dir*hbox.hit_effect_x), (y-50+hbox.y)/2+(hbox.hit_effect_y), HFX_SYL_WOOD_SMALL);
        
        mask_index = old_mask;
        return true;
    }
    
    mask_index = old_mask;
    return false;