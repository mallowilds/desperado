// css_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#css-draw-gml
// Draws the character select screen

//shader_end();
draw_set_halign(fa_left)
draw_set_font(asset_get("fName"))
draw_sprite(sprite_get("charselect_overlay"), get_player_color(player), x + 8, y + 8)
/*
//prev
draw_sprite_ext(sprite_get("bullet"), 0, bulletcoordbe[0], bulletcoordbe[1], 1, 1, 0, c_white, .5)

//post
draw_sprite_ext(sprite_get("bullet"), 0, bulletcoordab[0], bulletcoordab[1], 1, 1, 0, c_white, .5)
*/

//main
draw_sprite_tiled_area(sprite_get("bulletmid"), bsubimg, bulletcoordmain[0], bulletcoordmain[1], bulletcoordmain[0],  bulletcoordmain[1], bulletcoordmain[0] + bulletiple + 108, bulletcoordmain[1] + 38)
draw_sprite_ext(sprite_get("bullet_tip"), bsubimg, bulletcoordmain[0] + bulletiple, bulletcoordmain[1], 1, 1, 0, c_white, 1)


draw_text_transformed_color(bulletcoordmain[0] + 2, bulletcoordmain[1] + 12, alt_name[get_player_color(player)], 1, 1, 0, tcolor1, tcolor1, tcolor1, tcolor1, alpha_timer)
draw_text_transformed_color(bulletcoordmain[0] + 4, bulletcoordmain[1] + 12, alt_name[get_player_color(player)], 1, 1, 0, tcolor2, tcolor2, tcolor2, tcolor2, alpha_timer)
draw_sprite_ext(sprite_get("cssicons"), get_player_color(player), bulletcoordmain[0]+ bulletiple + 70, bulletcoordmain[1] - 2, 1, 1, 0, c_white, alpha_timer)

#define draw_sprite_tiled_area(sprite,subimg,x,y,x1,y1,x2,y2)
    //
    //  Draws a repeated sprite image, tiled to fill a given region and with
    //  a given offset. 
    //
    //      sprite      sprite to draw, real
    //      subimg      sprite subimage to draw, real
    //      x,y         origin offset, real
    //      x1,y1       top-left corner of tiled area, real
    //      x2,y2       bottom-right corner of tiled area, real
    //
    /// GMLscripts.com/license
    {
        var sprite,subimg,xx,yy,x1,y1,x2,y2;
        sprite = argument0;
        subimg = argument1;
        xx = argument2;
        yy = argument3;
        x1 = argument4;
        y1 = argument5;
        x2 = argument6;
        y2 = argument7;
     
        var sw,sh,i,j,jj,left,top,width,height,X,Y;
        sw = sprite_get_width(sprite);
        sh = sprite_get_height(sprite);
     
        i = x1-((x1 mod sw) - (xx mod sw)) - sw*((x1 mod sw)<(xx mod sw));
        j = y1-((y1 mod sh) - (yy mod sh)) - sh*((y1 mod sh)<(yy mod sh)); 
        jj = j;
     
        for(i=i; i<=x2; i+=sw) {
            for(j=j; j<=y2; j+=sh) {
     
                if(i <= x1) left = x1-i;
                else left = 0;
                X = i+left;
     
                if(j <= y1) top = y1-j;
                else top = 0;
                Y = j+top;
     
                if(x2 <= i+sw) width = ((sw)-(i+sw-x2)+1)-left;
                else width = sw-left;
     
                if(y2 <= j+sh) height = ((sh)-(j+sh-y2)+1)-top;
                else height = sh-top;
     
                draw_sprite_part(sprite,subimg,left,top,width,height,X,Y);
            }
            j = jj;
        }
        return 0;
    }