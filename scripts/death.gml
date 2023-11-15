// death.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#death-gml
// Called when your character dies.


// Reset bullets
num_bullets = 0;

// Reset skull
if (head_obj.state != 0 && head_obj.state != 4 && head_obj.state != 5) {
    head_obj.state = 4;
    head_obj.state_timer = 0;
    head_obj.window = 1;
    head_obj.window_timer = 1;
}

// Reset anti-stall checks
dairs_used = 0;
move_cooldown[AT_DSPECIAL] = 0;
move_cooldown[AT_USPECIAL] = 0;