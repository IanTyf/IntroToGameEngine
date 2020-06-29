objCount = 0;
canPlaySnd = true;
canDB = true;
isDead = false;
jp = 0;
//onground = false;
global.startTimer = false;
global.seconds = 0;
global.milliS = 0;
global.gameover = false;

strr = "";
var randint = irandom(4);
switch (randint) {
	case 0: strr = "Really? I thought you're better than this.";
			break;
	case 1: strr = "That's unfortunate.";
			break;
	case 2: strr = "You are just bad.";
			break;
	case 3: strr = "That wasn't even close.";
			break;
	case 4: strr = "You'll get lucky next time.";
			break;
}