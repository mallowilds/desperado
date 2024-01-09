// animation.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/animation_scripts.html#animation-gml
// Called each frame. For manually changing your sprite_index and image_index.

if state == PS_IDLE_AIR && prev_state == PS_FIRST_JUMP && djumps == 1 image_index = image_number-1;
if state == PS_IDLE_AIR && prev_state == PS_DOUBLE_JUMP image_index = image_number-1;

if state == PS_IDLE_AIR && prev_state == PS_ATTACK_AIR image_index = image_number-1;
if state == PS_IDLE_AIR && prev_state == PS_WALL_JUMP image_index = image_number-1;

if state == PS_AIR_DODGE && state_timer == 6 {
    if hsp < 5 && hsp > -4 && vsp > 7 {
        adown = 1
    } else {
        adown = 0
    }
}

if state == PS_IDLE_AIR && prev_state == PS_AIR_DODGE image_index = image_number-1;
if adown {
    air_dodge_recovery_frames = 3
} else {
    air_dodge_recovery_frames = 2
}

if (state == PS_ATTACK_AIR && (attack == AT_DAIR || attack == AT_USPECIAL) && window >= 4 && skull_grabbed) image_index += 6;

custom_crouch() // run the custom crouch code



//#region Skullessness management

if (head_obj.state != 0) {
	
	var _s = null;
	
	for (var i = 0; i < array_length(anim_list); i++) {
		if (sprite_index == sprite_get(anim_list[i])) {
			_s = anim_list[i];
		}
	}
	
	if (_s != null) {
	    _s = _s + "_skulless";
	    sprite_index = sprite_get(_s);
	    
	    if (_s == "idle_skulless") image_index = state_timer*idle_anim_speed;
	    else if (_s == "dash_skulless") image_index = state_timer*dash_anim_speed;
	    else if (_s == "walk_skulless") image_index = state_timer*walk_anim_speed;
	}
	
}

else if (state == PS_ATTACK_GROUND && attack == AT_USTRONG_2 && image_index > 4) { // Special handling since the attack shouldn't be changing mid-active frames
	sprite_index = sprite_get("ustrong");
}

else if (state == PS_ATTACK_GROUND && attack == AT_EXTRA_2 && image_index > 5) { // Ditto for DAttack
	sprite_index = sprite_get("dattack");
}

//#endregion


//#region Special alt management
// else-if chain continues from skullessness to prevent head pop-in
else if (display_seasonal && (state == PS_IDLE || state == PS_SPAWN || state == PS_RESPAWN)) {
	sprite_index = sprite_get("idle_holiday"+string(seasonal_type));
	image_index = state_timer*idle_anim_speed;
}

else if (is_genesis && (get_gameplay_time() <= 5 || attack == AT_INTRO && state == PS_ATTACK_GROUND && gen_image_index < 13.5)) {
	sprite_index = sprite_get("null");
}
//#endregion


// Defines always go at the bottom of the file.
#define custom_crouch()
// Crouch Animation Start/End Customization by @SupersonicNK
if state == PS_CROUCH {
	crouch_spr = sprite_index; //this should technically account for skin handler in most cases lol
	if !ccrouch_playing {
		ccrouch_playing = true;
		ccrouch_phase = 0;
		ccrouch_timer = 0;
		ccrouch_percent = 0;
	}
} else if state == clamp(state, 5, 6) { // Attacking
	switch (attack) {
		case AT_DTILT:
			if down_down {
				ccrouch_playing = true;
				ccrouch_phase = 1;
				ccrouch_timer = 0;
			} else {
				ccrouch_playing = false;
			}
			return; // prevent the actual animation logic from running, but this ensures you'll enter crouch anim after dtilt.
		default:
			ccrouch_playing = false;
			ccrouch_phase = 0;
			ccrouch_timer = 0;
			ccrouch_percent = 0;
			break;
	}
} else if state != PS_IDLE {
	ccrouch_playing = false;
}

if ccrouch_playing {
	var duration
	switch (ccrouch_phase) {
		case 0: 
			duration = crouch_start_time;
			ccrouch_percent = clamp(ccrouch_timer/duration,0,1)
			image_index = lerp(0,crouch_startup_frames,ccrouch_percent)
			if ccrouch_percent == 1 { // to loop
				ccrouch_phase = 1;
				ccrouch_timer = 0;
			}else if !down_down { // to uncrouch
				ccrouch_timer = floor(crouch_end_time * (1-ccrouch_percent));
				ccrouch_phase = 2;
			}
			break;
		case 1:
			image_index = crouch_startup_frames + ( (ccrouch_timer) * crouch_anim_speed % crouch_active_frames )
			if !down_down {
				ccrouch_timer = 0;
				ccrouch_phase = 2;
			}
			break;
		case 2: // uncrouch
			duration = crouch_end_time+1; // the + 1 is so the frame time is accurate due to how i stop it
			ccrouch_percent = clamp(ccrouch_timer/duration,0,1)
			if !down_down && ccrouch_percent == 1 { // finish crouching. interrupting it here 
				ccrouch_playing = false;
				break;
			}
			sprite_index = crouch_spr; // this is the only part of crouch that needs the sprite to be set to crouch lol
			var start = crouch_startup_frames+crouch_active_frames;
			image_index = lerp(start, start+crouch_recovery_frames, ccrouch_percent)
			if down_down { // recrouch
				ccrouch_timer = floor(crouch_start_time * (1-ccrouch_percent))
				ccrouch_phase = 0;
			}
			break;
	}
	ccrouch_timer++;
}