// set_attack.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#in-response
// Called at the beginning of every attack. Used to replace the attack in special conditions.


switch attack {
    case AT_JAB:
        //attack = AT_INTRO //just used to test the intro lol
        break;
        
    // Skullless normals
    case AT_DATTACK:
        if (head_obj.state != 0) attack = AT_EXTRA_2;
        break;
    case AT_USTRONG:
        if (head_obj.state != 0) attack = AT_USTRONG_2;
        break;
    
    // Empowered normals
    case AT_FSTRONG:
        if (num_bullets > 0) attack = AT_FSTRONG_2;
        break;
    case AT_BAIR:
        if (num_bullets >= 4) attack = AT_EXTRA_1;
        break;
    
    // FSpecial command
    case AT_FSPECIAL:
        if (head_obj.state != 0) attack = AT_FSPECIAL_2;
        break;
    
    // Taunt 2 / destroy signpost
    case AT_TAUNT:
        if (instance_exists(signpost_obj)) attack = AT_TAUNT_2;
        break;
    
}