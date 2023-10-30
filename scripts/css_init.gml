//do a url check before release
sound_play(sound_get("desp_click"))



alt_name[0]  = "Ashes to Ashes"; 
alt_name[1]  = "Dreadnought"; 
alt_name[2]  = "Scorchshot"; 
alt_name[3]  = "Earthrot"; 
alt_name[4]  = "Skysought"; 
alt_name[5]  = "Dust & Desire"; 
alt_name[6]  = "Doubt"; 
alt_name[7]  = "Timeless"; 
alt_name[8]  = "Posession   ";
alt_name[9]  = "Blind Obsession";
alt_name[10]  = "Dies Irae";
alt_name[11]  = "Desperate Outlaw      ";
alt_name[12]  = "In the Blood";
alt_name[13]  = "Hunted";
alt_name[14]  = "Blasted";


bulletcoordmain = [10, 120]
bulletcoordbe = [12, 110]
bulletcoordab = [12, 130]

bullet1cur = [bulletcoordmain[0], bulletcoordmain[1]]

bulletiple = 0
bulletip_mark = 0
bulletsink_start = 0
bulletsink_end = bulletcoordmain[0] - 60

css_timer= 0
alt_timer = 0 
altcur = get_player_color(player)
alpha_timer = 1



alt_timer = 0 
altcur = get_player_color(player)
bulletsink = 0
bulletsink_start = string_length(alt_name[get_player_color(player)]) * 2 - 20 + bulletsink
alpha_timer = 1

bsubimg = 0
tcolor1 = c_black
tcolor2 = c_white

eacolor1 = /*#*/$3f5a2a
eacolor2 = /*#*/$3a9159