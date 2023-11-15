// death.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#death-gml
// Called when your character dies.


// Reset bullets
num_bullets = 0;

// Reset anti-stall checks
dairs_used = 0;
move_cooldown[AT_DSPECIAL] = 0;
move_cooldown[AT_USPECIAL] = 0;