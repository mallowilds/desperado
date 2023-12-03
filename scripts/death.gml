// death.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#death-gml
// Called when your character dies.


// Reset bullets
var do_visual = false;
if (x <= get_stage_data(SD_LEFT_BLASTZONE_X) || x >= get_stage_data(SD_RIGHT_BLASTZONE_X)) {
    do_visual = true;
    var v_hsp = x < get_stage_data(SD_LEFT_BLASTZONE_X) ? 5 : -5;
    var v_hsp_var = x < get_stage_data(SD_LEFT_BLASTZONE_X) ? 2 : -2;
    var v_vsp = -6;
    var v_vsp_var = -3;
}
else if (y <= get_stage_data(SD_TOP_BLASTZONE_Y) || y >= get_stage_data(SD_TOP_BLASTZONE_Y)) {
    do_visual = true;
    var v_hsp = -2;
    var v_hsp_var = 4;
    var v_vsp = y < get_stage_data(SD_TOP_BLASTZONE_Y) ? 4 : -17;
    var v_vsp_var = 2;
}

var num_removed = 0;
while (num_bullets > 0 && num_removed < 3) {
    num_bullets--;
    num_removed++;
    
    if (do_visual) {
        var bullet_casing = instance_create(x, y-1, "obj_article3");
        bullet_casing.state = 00;
        bullet_casing.hsp = v_hsp + v_hsp_var*random_func(3*num_removed+1, 1, false);
        bullet_casing.vsp = v_vsp + v_vsp_var*random_func(3*num_removed+2, 1, false);
    }
    
}

// Reset skull
if (head_obj.state != 0 && head_obj.state != 4 && head_obj.state != 5 && !head_obj.getting_bashed) {
    head_obj.state = 4;
    head_obj.state_timer = 0;
    head_obj.window = 1;
    head_obj.window_timer = 1;
}

// Reset anti-stall checks
dairs_used = 0;
move_cooldown[AT_DSPECIAL] = 0;
move_cooldown[AT_USPECIAL] = 0;