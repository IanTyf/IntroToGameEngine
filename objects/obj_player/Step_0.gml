vspeed += 0.5;

// ground check
var onground;
if (vspeed >= 0) {
	onground = place_meeting(x, y+vspeed+0.5, obj_wall);
	if (onground) {
		show_debug_message("vspeed: "+string(vspeed)+", hello??");
		vspeed = 0;
		canDB = true;
		jp = 0;
	}
}
else {
	onground = false;
}

// movement
if (!isDead) {
	if (keyboard_check(vk_left)) {
		hspeed = lerp(hspeed, -5, 0.1);
		if (canDB) {
			sprite_index = spr_playerWalk;
		}
		else {
			sprite_index = spr_dbJump;
		}
		image_xscale = -1;
	}
	else if (keyboard_check(vk_right)) {
		hspeed = lerp(hspeed, 5, 0.1);
		if (canDB) {
			sprite_index = spr_playerWalk;
		}
		else {
			sprite_index = spr_dbJump;
		}
		image_xscale = 1;
	}
	else {
		hspeed = lerp(hspeed, 0, 0.3);
		if (canDB) {
			sprite_index = spr_playerIdle;
		}
		else {
			sprite_index = spr_dbJump;
		}
		if (hspeed > 0) image_xscale = 1;
		else if (hspeed < 0) image_xscale = -1;
	}


	if (keyboard_check_pressed(vk_space)) {
		//if (onground) {
		if (jp == 0) {
			vspeed = -8 - abs(hspeed)/1;
			canDB = true;
			jp = 1;
			sprite_index = spr_playerIdle;
		}
		else {
			if (jp == 1) {
				vspeed = -10 - abs(hspeed)/1;
				canDB = false;
				jp = 2;
				sprite_index = spr_dbJump;
			}
		}
	}
}

// wall collision
if (place_meeting(x+hspeed, y+vspeed+0.5, obj_wall)) {
	if (place_meeting(x+hspeed, y, obj_wall)) {
		hspeed = 0;
	}
	if (place_meeting(x, y+vspeed, obj_wall)) {
		vspeed = 0;
	}
}
else {	
	
}


// check for obj collision
if (place_meeting(x, y, obj_obj)) {
	if (canPlaySnd) {
		audio_play_sound(snd_pickup, 10, false);
		canPlaySnd = false;
		alarm_set(1, 50);
	}
	if (!global.startTimer) {
		global.startTimer = true;
		alarm_set(0, 60);
	}
	var objj = instance_place(x, y, obj_obj);
	objCount++;
	with (objj) {
		instance_destroy();
	}
	switch (objCount) 
	{
		case 1: instance_create_depth(30, 3264, 10, obj_obj);
				break;
		case 2: instance_create_depth(696, 3456, 10, obj_obj);
				break;
		case 3: instance_create_depth(912, 3648, 10, obj_obj);
				break;
		case 4: instance_create_depth(696, 3456, 10, obj_obj);
				break;
		case 5: instance_create_depth(928, 3232, 10, obj_obj);
				break;
		case 6: instance_create_depth(696, 2944, 10, obj_obj);
				break;
		case 7: instance_create_depth(304, 2784, 10, obj_obj);
				break;
		case 8: instance_create_depth(592, 2560, 10, obj_obj);
				break;
		case 9: instance_create_depth(672, 2336, 10, obj_obj);
				break;		
		case 10: instance_create_depth(936, 2240, 10, obj_obj);
				break;
		case 11: //game over
				global.gameover = true;
				audio_play_sound(snd_victory, 10, false);
				break;
	}
}

// get hit by obstacles
if (place_meeting(x, y, obj_spike)) {
	isDead = true;
	//play animation
	sprite_index = spr_playerDie;
	hspeed = 0;
}

// restart
if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}
if ((global.gameover && keyboard_check(vk_enter)) || keyboard_check(vk_lcontrol)) {
	var next = room_next(room);
	if (next != -1) {
		room_goto_next();
	}
}
