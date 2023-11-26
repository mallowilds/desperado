// hit_player.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#hit-player-gml
// Called when you hit aatk = my_hitboxID.attack 
atk = my_hitboxID.attack 
hbox = my_hitboxID.hbox_num


//#region Damage multiplier & 4+ Bullet SFX

// Base amp
var mult_damage_add = my_hitboxID.damage * (num_bullets*bullet_mult);
take_damage(hit_player_obj.player, player, floor(mult_damage_add));

// Buffer non-integer damage, apply buffer as needed
if (!hit_player_obj.clone) {
	hit_player_obj.u_mult_damage_buffer += mult_damage_add - floor(mult_damage_add);
	if (hit_player_obj.u_mult_damage_buffer >= 1) {
	    take_damage(hit_player_obj.player, player, floor(hit_player_obj.u_mult_damage_buffer));
	    hit_player_obj.u_mult_damage_buffer -= floor(hit_player_obj.u_mult_damage_buffer);
	}
}

if (my_hitboxID.damage + mult_damage_add > 3 && num_bullets >= 4) {
	sound_play(sound_get("desp_knock"));
}

//#endregion


//#region Skull hitbox management
if (atk == AT_FSPECIAL && my_hitboxID.orig_player == player) { // FSpecial
	my_hitboxID.head_obj.hitstop = hit_player_obj.hitstop;
	my_hitboxID.head_obj.has_hit = true;
}
if (atk == 42 && my_hitboxID.orig_player == player) { // Sync attacks
	my_hitboxID.head_obj.hitstop = hit_player_obj.hitstop;
	my_hitboxID.head_obj.has_hit = true;
	my_hitboxID.head_obj.can_hit[hit_player+1] = false;
	
	with pHitBox {
		if ("head_obj" in self && head_obj == other.my_hitboxID.head_obj && attack == 42) {
			can_hit[other.hit_player+1] = false;
		}
	}
}
//#endregion



//#region SFX management
if atk == AT_EXTRA_1 && hbox == 3 {
	sound_play(sound_get("desp_weirdhit"))
}
if atk == AT_FAIR && hbox != 4 {
    hit_player_obj.x = lerp(floor(hit_player_obj.x), x+10 * spr_dir, .4)
    hit_player_obj.y = lerp(floor(hit_player_obj.y), y-5, .4)
    sound_play(sound_get("desp_cast_short"), 0, noone, 0.9, 1)
}
if atk == AT_FAIR && hbox == 4 {
	sound_play(sound_get("desp_cast_short"), 0, noone, 0.9, 1)
}
if atk == AT_UTILT {
	//sound_play(sound_get("desp_cast_short"), 0, noone, 0.9, 1)
}
if atk == AT_NSPECIAL {
	if hbox == 1 {
		sound_play(sound_get("hit_p00_a"))
	}
	if hbox == 2 {
		sound_play(sound_get("desp_heavy_hit"))
	}
}
//#endregion


//#region Hit FX management
with hit_fx_obj {
	if player_id == other.id {
        if hit_fx == other.hfx_bone_large {
            depth = other.depth-1
        }
    }
}
//#endregion