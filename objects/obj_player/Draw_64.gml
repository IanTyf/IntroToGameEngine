draw_set_color(c_white);
draw_set_font(fnt_default);

if (global.startTimer) {
	global.milliS++;
	if (global.milliS == 60) {
		global.milliS = 0;
	}
}
var sss = string_format(global.seconds, 2, 0) + ":" + string_format(global.milliS, 2, 0);
draw_set_halign(fa_left);
draw_text(25, 30, "Time: " + sss);

if (global.gameover) {
	global.startTimer = false;
	//display end game screen
	draw_set_halign(fa_center);
	draw_text(512, 200, "Congrats! Your finish time is " + sss);
	draw_text(512, 260, "Press <ENTER> to move to the next level");
}
else {
	if (isDead) {
		draw_set_halign (fa_center);
		draw_text(512, 280, strr);
	}
	else if (objCount == 0) {
		draw_set_halign(fa_center);
		draw_text(512, 200, "Touch the yellow ball to start");
		draw_text(512, 260, "Press <R> at any time to retry");
	}
}
