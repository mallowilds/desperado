
// article1_init - runs once, when the article is created
// Desperado's skull.
// Spawned by init.gml and update.gml.

//Sprite and direction
sprite_index = sprite_get("skullidle");             //The sprite that the article will (initially) use. Replace text in quotes with your sprite's name
image_index = 0;                                    //The frame in the animation the article should start at. 0 = beginning of animation
spr_dir = player_id.spr_dir;                        //The direction the article should face when it spawns. Here I have it set to face the same way as the character
uses_shader = true;                                 //Whether or not the article is recolored according to the character's color.gml and costume.
mask_index = sprite_get("skullhurtbox");

//State
state = 0;                                          //The behavior state the article should start in.
state_timer = 0;                                    //The point in time during that state the article should start in. (0 = beginning)
window = 0;
window_timer = 0;
hitstop = 0;                                        //The frames remaining in hitpause. Hitpause automatically prevents movement
hsp = 0;                                            //The horizontal speed of the article. Multiply by spr_dir to correctly handle forward (+) or backward (-) movement
vsp = 0;                                            //The vertical speed of the article.
has_hit = false;

hittable = false;

respawn_penalty = true;                             // If set to false, removes penalty delay and spawns a hitbox on return
respawn_delay = 60;
penalty_delay = 30;

can_fspecial = false;
skull_stored_attack = noone;

shots_absorbed = 0;
redir_angle = 0;
redir_target_obj = noone;
shot_visual = noone;

//Terrain behavior
can_be_grounded = false;                            //Determines if the article follows platforms when free == false.
ignores_walls = false;                              //Determines if the article goes through walls.
free = true;                                        //Whether the article is in the air or not.
hit_wall = false;                                   //If the article moves into a wall on its own, this variable will be true.

//Ownership management (ori really likes stealing this :( )
orig_player = player;
orig_player_id = player_id;
hud_arrow = sprite_get("skull_hud_arrow");




// Supersonic Hit Detection Template
//make hbox_group array (the old version was really bad because the array actually affected all players no matter what lol)
hbox_group = array_create(4,0);
var i1 = 0;
var i2 = 0;
repeat(4) {
    hbox_group[@i1] = array_create(50,0);
    repeat(50) {
        hbox_group[@i1][@i2] = array_create(10,0);
        i2++;
    }
    i2 = 0;
    i1++;
}
 
hitstun = 0;
hitstun_full = 0;
 
kb_adj = 1;
kb_dir = 0;
orig_knock = 0;
 
hit_lockout = 0;
 
article_should_lockout = true; //set to false if you don't want hit lockout.