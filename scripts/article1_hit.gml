

// article1_hit - A got_hit script.
// Handles vfx spawning, knockback, damage, etc.



// Dan pls :(
if (enemy_hitboxID.hbox_group == -1) {
    
    var hit_var_name = "desp_skull_hittable_" + string(player);
    
    if !(hit_var_name in enemy_hitboxID) {
        variable_instance_set(enemy_hitboxID, hit_var_name, false);
    }
    
    else {
        hit_player_obj.hitstop = hitstop;
        exit;
    }
    
}


// DAN PLS
if (enemy_hitboxID.hit_priority <= 0) {
    exit;
}

with enemy_hitboxID {
    
    if (sound_effect != 0) sound_play(sound_effect);
    var hfx_x = (x + other.x) / 2 + (hit_effect_x*spr_dir);
    var hfx_y = (y + other.y) / 2 + hit_effect_y;
    spawn_hit_fx(hfx_x, hfx_y, hit_effect);
    
}

if (enemy_hitboxID.type != 2) {
    if (last_attack[hit_player] != enemy_hitboxID.attack || enemy_hitboxID.attack == AT_JAB) health--; // Jab check is hacky :(
    last_attack[hit_player] = enemy_hitboxID.attack;
}
else health--;

hitstop = hit_player_obj.hitstop;

state = 2;
state_timer = 0;
var orig_knock = get_kb_formula( 0, 0.9, 1, enemy_hitboxID.damage, enemy_hitboxID.kb_value, enemy_hitboxID.kb_scale );
hsp = lengthdir_x(orig_knock, hit_dir);
vsp = lengthdir_y(orig_knock, hit_dir);
moving_vertically = (hsp == 0);
sprite_index = sprite_get("skull_hurt");