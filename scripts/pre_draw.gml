// pre_draw.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#draw-scripts
// Draws BEHIND your character

shader_start();


// NSpecial shots
for (var i = 0; i < ds_list_size(nspec_shot_list); i++) {
    var sp = ds_list_find_value(nspec_shot_list, i);
    var _x = sp.sp_x;
    var _y = sp.sp_y;
    var _spr_dir = sp.sp_spr_dir;
    
    var smoke_start_time = sp.sp_smoke_time_offset + sp.sp_shot_lifetime
    if (sp.sp_lifetime >= smoke_start_time) {
        
        var smoke_sprite_index = sp.sp_smoke_index;
        var smoke_y_offset = sprite_get_yoffset(smoke_sprite_index);
        
        var sp_image_index = (sp.sp_lifetime-smoke_start_time) * (sprite_get_number(smoke_sprite_index) / sp.sp_smoke_lifetime);
        var sp_start_width = min(sprite_get_width(smoke_sprite_index), sp_length)
        var sp_x_near = _x+(_spr_dir*sprite_get_xoffset(smoke_sprite_index))
        var sp_x_far = _x+(_spr_dir*sp_length)
        var tile_tl_x = (sp_x_far < _x ? sp_x_far : sp_x_near);
        var tile_br_x = (sp_x_far > _x ? sp_x_far : sp_x_near);

        draw_sprite_tiled_area(smoke_sprite_index, sp_image_index, sp_x_near, _y-smoke_y_offset, tile_tl_x, _y-smoke_y_offset, tile_br_x, _y-smoke_y_offset+sprite_get_height(smoke_sprite_index));

    }
    
    if (sp.sp_lifetime < sp.sp_shot_lifetime) {
        
        var tile_sprite_index = sp.sp_tile_index;
        var start_sprite_index = sp.sp_start_index;
        var sp_length = sp.sp_length;
        
        var sp_image_index = sp.sp_lifetime * (sprite_get_number(tile_sprite_index) / sp.sp_shot_lifetime);
        var sp_start_width = min(sprite_get_width(start_sprite_index), sp_length)
        var sp_x_far = _x+(_spr_dir*(sp_length-sp.sp_edge_width))
        var tile_tl_x = (sp_x_far < _x ? sp_x_far : _x+(_spr_dir*sprite_get_width(start_sprite_index)));
        var tile_br_x = (sp_x_far > _x ? sp_x_far : _x+(_spr_dir*sprite_get_width(start_sprite_index)));
        
        // Draw priority: tile < end < start
        if (sp_length > 44) {
            draw_sprite_tiled_area(tile_sprite_index, sp_image_index, _x, _y-sprite_get_yoffset(tile_sprite_index), tile_tl_x, _y-sprite_get_yoffset(tile_sprite_index), tile_br_x, _y+(sprite_get_height(tile_sprite_index)/2))
            draw_sprite_ext(sp.sp_edge_index, sp_image_index, sp_x_far, _y, _spr_dir, 1, 0, c_white, 1);
        }
        draw_sprite_part_ext(start_sprite_index, sp_image_index, 0, 0, sp_start_width, sprite_get_height(start_sprite_index), _x, _y-sprite_get_yoffset(start_sprite_index), _spr_dir, 1, c_white, 1);
        
    }
    
}

// Genesis alt intro (self-targeted)
if (is_genesis && self == genesis_spawn_player_id && attack == AT_INTRO && state == PS_ATTACK_GROUND && gen_image_index < 14.5) {
    createMask(sprite_get("staticimg"));
}

// Genesis taunt (Giik's genesis effect)
if (is_genesis && random_func(player+1, 2, 1) == 0 && state == PS_ATTACK_GROUND && attack == AT_TAUNT_GEN && window == 2) {
    var fs = random_func(player+2, sprite_height-1, 1);
    draw_sprite_part_ext(sprite_index,image_index,0,fs, abs(sprite_width), random_func(1, 20, 1)+1, (x+(random_func(2, 3, 1)-1)*11) - sprite_get_xoffset(sprite_index)*spr_dir, y+fs - sprite_get_yoffset(sprite_index), spr_dir, 1, image_blend, 0.8);
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

#define maskHeader()
// Mask renderer utility: disables Normal draw.
// Draw shapes or sprites to be used as the stencil(s) by maskMidder.
//================================================================================
{
    gpu_set_blendenable(false);
    gpu_set_colorwriteenable(false,false,false,true);
    
}
//================================================================================
#define maskMidder()
// Reenables draw but only within the region drawn between maskHeader and maskMidder.
// Lasts until maskFooter is called.
//================================================================================
{
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true,true,true,true);
    gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
    gpu_set_alphatestenable(true);
}
//================================================================================
#define maskFooter()
// Restores normal drawing parameters//================================================================================
{
    gpu_set_alphatestenable(false);
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}
//================================================================================
#define createMask(the_image) // heavily modified
// creates the masking//================================================================================
{
    maskHeader();
    maskMidder();
    maskFooter();
    shader_start();
    draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, 1);
    shader_end();
    maskHeader();
    draw_set_alpha(0);
    draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, c_white, c_white, 0);
    draw_set_alpha(1);
    draw_sprite_ext(sprite_get("intro_gen"), gen_image_index, other.x-(50*other.spr_dir), other.y, other.spr_dir, 1, 0, c_white, .15);
    maskMidder();
    shader_start();
    draw_sprite_tiled_ext(the_image, 0, 0, 0, .5, .5, c_white, 1);
    shader_end();
    maskFooter();
}