
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

health = 1;
max_health = 1;
last_attack = [noone, noone, noone, noone, noone];
hittable_hitpause_mult = 1;

can_fspecial = false;
can_sync_attack = false;
skull_stored_attack = noone;

//Terrain behavior
can_be_grounded = false;                            //Determines if the article follows platforms when free == false.
ignores_walls = false;                              //Determines if the article goes through walls.
free = true;                                        //Whether the article is in the air or not.
hit_wall = false;                                   //If the article moves into a wall on its own, this variable will be true.

//Ownership management (ori really likes stealing this :( )
orig_player = player;
orig_player_id = player_id;
hud_arrow = sprite_get("skull_hud_arrow");