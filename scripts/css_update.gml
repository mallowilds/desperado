
if ("alt_timer" not in self) exit;

//get cursor pos
alt_timer++;
css_timer++;
var cur_i = 5
var cur_x
var cur_y
with (asset_get("cs_playercursor_obj")) {
    cur_i-- //because the instance order of the cursors
    cur_x[cur_i] = get_instance_x(self) //this works
    cur_y[cur_i] = get_instance_y(self)
}


//21, 455
if altcur != get_player_color(player) {
    alt_timer = 0 
    altcur = get_player_color(player)
    sound_play(sound_get("desp_smallclick"), noone, 0, 2, 1)
    bulletsink = 0
    bulletsink_start = string_length(alt_name[get_player_color(player)]) * 2 - 20 + bulletsink
    alpha_timer = 1
}
if alt_timer > 0 && alt_timer < 4 {
    bulletiple = lerp(bulletiple, bulletsink_start, 0.8)
}

if alt_timer > 56 && alt_timer < 61 {
        alpha_timer -= 0.25
}
if alt_timer > 60  && alt_timer < 66 {
    bulletsink = -100
    bulletiple = lerp(bulletiple, bulletsink, 0.5)
}
sound_stop(asset_get("mfx_change_color"))

if get_player_color(player) == 7 {
    tcolor1 = eacolor2
    tcolor2 = eacolor1
    bsubimg = 1
} else {
    tcolor1 = c_black 
    tcolor2 = c_white
    bsubimg = 0
}