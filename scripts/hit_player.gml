// hit_player.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#hit-player-gml
// Called when you hit aatk = my_hitboxID.attack 
atk = my_hitboxID.attack 
hbox = my_hitboxID.hbox_num


if atk == AT_FAIR && hbox != 4 {
    hit_player_obj.x = lerp(floor(hit_player_obj.x), x+10 * spr_dir, .4)
    hit_player_obj.y = lerp(floor(hit_player_obj.y), y-5, .4)
    sound_play(sound_get("hit_p00_a"), 0, noone, 0.6, 1)
}
if atk == AT_FAIR && hbox == 4 {
	sound_play(sound_get("hit_p00_b"), 0, noone, 0.6, 1)
}
with hit_fx_obj {
	if player_id == other.id {
        if hit_fx == other.hfx_bone_large {
            depth = other.depth-1
        }
    }
}