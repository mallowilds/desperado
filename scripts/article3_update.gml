
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
    case 10:
        sprite_index = sprite_get("sign");
        mask_index = sprite_get("sign_mask");
        y += 1 // honestly idk
        
        //get highest-damage opponent icon
        top_damage = -1;
        icon_spr = get_char_info(player, INFO_ICON) // default to desp if things fail
        icon_image = 0;
        icon_scale = 1;
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
        for (var i = 1; i <= 4; i++) {
            if (i != player && get_player_damage(i) > top_damage) {
                get_char_info(i, INFO)
                top_damage = get_player_damage(i)
                icon_spr = get_char_info(i, INFO_ICON);
            }
        }
        
        state = 11;
        state_timer = 0;
        break;
    
    case 11:
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