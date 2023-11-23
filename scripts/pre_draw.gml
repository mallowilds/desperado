// pre_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws BEHIND your character

shader_start();

// NSpecial shots
for (var i = 0; i < ds_list_size(nspec_shot_list); i++) {
    var sp = ds_list_find_value(nspec_shot_list, i);
    
    if (sp.sp_lifetime < sp.sp_shot_lifetime) {
        var sp_image_index = sp.sp_lifetime * (sprite_get_number(sp.sp_tile_index) / sp.sp_shot_lifetime);
        
        var sp_start_width = min(sprite_get_width(sp.sp_start_index), sp.sp_length)
        var sp_x_far = sp.sp_x+(sp.sp_spr_dir*(sp.sp_length-sp.sp_edge_width))
        var tile_tl_x = (sp_x_far < sp.sp_x ? sp_x_far : sp.sp_x+(sp.sp_spr_dir*sprite_get_width(sp.sp_start_index)));
        var tile_br_x = (sp_x_far > sp.sp_x ? sp_x_far : sp.sp_x+(sp.sp_spr_dir*sprite_get_width(sp.sp_start_index)));
        
        // Draw priority: tile < end < start
        if (sp.sp_length > 44) {
            draw_sprite_tiled_area(sp.sp_tile_index, sp_image_index, sp.sp_x, sp.sp_y-sprite_get_yoffset(sp.sp_tile_index), tile_tl_x, sp.sp_y-sprite_get_yoffset(sp.sp_tile_index), tile_br_x, sp.sp_y+(sprite_get_height(sp.sp_tile_index)/2))
            draw_sprite_ext(sp.sp_edge_index, sp_image_index, sp_x_far, sp.sp_y, sp.sp_spr_dir, 1, 0, c_white, 1);
        }
        draw_sprite_part_ext(sp.sp_start_index, sp_image_index, 0, 0, sp_start_width, sprite_get_height(sp.sp_start_index), sp.sp_x, sp.sp_y-sprite_get_yoffset(sp.sp_start_index), sp.sp_spr_dir, 1, c_white, 1);
    }
    
    var smoke_start_time = sp.sp_smoke_time_offset + sp.sp_shot_lifetime
    if (sp.sp_lifetime >= smoke_start_time) {
        
        var sp_image_index = (sp.sp_lifetime-smoke_start_time) * (sprite_get_number(sp.sp_smoke_index) / sp.sp_smoke_lifetime);
        var sp_start_width = min(sprite_get_width(sp.sp_smoke_index), sp.sp_length)
        var sp_x_near = sp.sp_x+(sp.sp_spr_dir*sprite_get_xoffset(sp.sp_smoke_index))
        var sp_x_far = sp.sp_x+(sp.sp_spr_dir*sp.sp_length)
        var tile_tl_x = (sp_x_far < sp.sp_x ? sp_x_far : sp_x_near);
        var tile_br_x = (sp_x_far > sp.sp_x ? sp_x_far : sp_x_near);

        draw_sprite_tiled_area(sp.sp_smoke_index, sp_image_index, sp_x_near, sp.sp_y-sprite_get_yoffset(sp.sp_smoke_index), tile_tl_x, sp.sp_y-sprite_get_yoffset(sp.sp_smoke_index), tile_br_x, sp.sp_y-sprite_get_yoffset(sp.sp_smoke_index)+sprite_get_height(sp.sp_smoke_index));

    }
    
}

shader_end();


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
        subimg = argument1; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        xx = argument2; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        yy = argument3; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        x1 = argument4; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        y1 = argument5; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        x2 = argument6; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        y2 = argument7; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
     
        var sw,sh,i,j,jj,left,top,width,height,X,Y;
        sw = sprite_get_width(sprite);
        sh = sprite_get_height(sprite); // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
     
        i = x1-((x1 mod sw) - (xx mod sw)) - sw*((x1 mod sw)<(xx mod sw));
        j = y1-((y1 mod sh) - (yy mod sh)) - sh*((y1 mod sh)<(yy mod sh));  // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        jj = j; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
     
        for(i=i; i<=x2; i+=sw) {
            for(j=j; j<=y2; j+=sh) {
     
                if(i <= x1) left = x1-i;
                else left = 0;
                X = i+left; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
     
                if(j <= y1) top = y1-j;
                else top = 0;
                Y = j+top; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
     
                if(x2 <= i+sw) width = ((sw)-(i+sw-x2)+1)-left;
                else width = sw-left;
     
                if(y2 <= j+sh) height = ((sh)-(j+sh-y2)+1)-top;
                else height = sh-top;
     
                draw_sprite_part(sprite,subimg,left,top,width,height,X,Y);
            }
            j = jj; // WARN: Possible Desync. Object var set in draw script. Consider using `var` or creating constants in `init.gml`.
        }
        return 0;
    }