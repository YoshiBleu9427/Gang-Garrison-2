global.lastNode = noone;

var xpos, ypos;
xpos = map_width() / 2;
ypos = map_height() / 2;

// first detect a point in the middle of the map where a character could stand
while(collision_line(xpos,ypos,xpos,ypos-48,Obstacle,true,false) > 0) {
    ypos-= 6;
}

// then init

// move left
// check if still on platform
// see if can jump to a platform from here
// continue
getPlatform(xpos,ypos,true);  // left
getPlatform(xpos,ypos,false); // right
