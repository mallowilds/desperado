// set_attack.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#in-response
// Called at the beginning of every attack. Used to replace the attack in special conditions.


switch attack {
    case AT_JAB:
        //attack = AT_INTRO //just used to test the intro lol
        break;
        
    // Skullless Normals
    case AT_DATTACK:
        if (head_obj.state != 0) attack = AT_EXTRA_2;
        skull_stored_attack = AT_NAIR;
        break;
    case AT_USTRONG:
        if (head_obj.state != 0) attack = AT_USTRONG_2;
        break;
    
    // Empowered FStrong
    case AT_FSTRONG:
        if (num_bullets > 0) attack = AT_FSTRONG_2;
        break;
    
    // Empowered BAir
    case AT_BAIR:
        if (num_bullets >= 4) attack = AT_EXTRA_1;
    
    case AT_UAIR:
    case AT_DAIR:
    case AT_FAIR:
    case AT_FTILT:
    case AT_DTILT:
    case AT_UTILT:
        skull_stored_attack = AT_NAIR;
        break;
    
    case AT_FSPECIAL:
        if (head_obj.state != 0) attack = AT_FSPECIAL_2;
        break;
        
    
}