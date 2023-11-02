// set_attack.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#in-response
// Called at the beginning of every attack. Used to replace the attack in special conditions.


switch attack {
    case AT_JAB:
        //attack = AT_INTRO //just used to test the intro lol
        break;
    // Empowered BAir
    case AT_BAIR:
        if (num_bullets >= 4) attack = AT_EXTRA_1;
        break;
    
    
}