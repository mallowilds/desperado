// draw_hud.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-hud-gml
// Used to draw the character's hud.
// The base location of their hud is available as `temp_x` and `temp_y`.

/*desperado hud will show his revolver with the amount of bullets in it, up to 6. 
/*sprite is desp_hud

you can do this however you want, BUT the way i figured might be pretty simple to impliment would be to use article color slots with an empty article to link each bullet color to a slot and manually change them to either desperados Ash color, or the darkest color of his gun.
If this is too complicated or annoying to impliment, let me know, or pitch a different way to do it, and i can try that. This is why the bullets are all different colors, though.
When desperado spins his barrel, which he does before reloading an attack (will probably just be jab + dspecial, as well as a visual flare for fstrong), it should have the hud barrel spin (you can see the .ase file to see how it should generally work), 
With the spinning being a set of 2 anim frames that repeat every 8 or so in game frames.
When desperado shoots the gun (uses nspecial), it should play the Shoot anim (which isnt finished btw lol), for each bullet unloaded.
*/

// Anim frame management
var frame = 0;
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) {
    if (attack == AT_DSPECIAL) {
        switch window {
            case 1:
                frame = floor(2*window_timer/get_window_value(attack, window, AG_WINDOW_LENGTH));
                break;
            case 2:
                frame = 3 + (window_timer/3)%2;
                break;
            case 3:
                frame = 5 + floor(window_timer/2);
                if (frame >= 9) frame = 0;
                break;
            
        }
    }
    
    
}



// Draw
var my_color = get_player_color(player);

for (var i = 5; i >= num_bullets; i--) {
    set_article_color_slot(i, floor(get_color_profile_slot_r(my_color, 7)*0.75), floor(get_color_profile_slot_g(my_color, 7)*0.75), floor(get_color_profile_slot_b(my_color, 7)*0.75));
}

for (var i = 0; i < num_bullets; i++) {
    set_article_color_slot(i, get_color_profile_slot_r(my_color, 3), get_color_profile_slot_g(my_color, 3), get_color_profile_slot_b(my_color, 3));
}

shader_start();
draw_sprite(sprite_get("desp_hud"), frame, temp_x, temp_y-98);
shader_end();