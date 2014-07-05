var xpos, ypos, goingLeft;
xpos = argument0;
ypos = argument1;
goingLeft = argument2;

var xshift;
if(goingLeft) xshift = -6;
else          xshift = 6;

var jumpLength, jumpHeight;
jumpLength = 48;
jumpHeight = 48;

var hitObstacle, i;
hitObstacle = false;
    
while((ypos > 0 and ypos < map_height()) and (!hitObstacle)) {
    ypos += 6; // get closer to the ground
    hitObstacle = nodingHitObstacle(xpos,ypos);
}

while((xpos > 0 and xpos < map_width()) and (ypos > 0 and ypos < map_height()) and (hitObstacle)) {

    var highy, lowy, lasty;
    highy = ypos - jumpHeight;
    lowy = ypos + jumpHeight;
    lasty = ypos;
    
    xpos += xshift; // progress
    hitObstacle = nodingHitObstacle(x,y);
    
    // I just left the ground! Is this a stair? Can I jump back?
    if(not hitObstacle) {
        for(; (ypos < lowy) and !hitObstacle; ypos += 6) {
            hitObstacle = nodingHitObstacle(xpos,ypos);
        }
        if(not hitObstacle) // you're still in air? You can't come back to that platform. Leave it.
            return 0;
    }
    
    // stick to the upper bound of the ground
    for(i = ypos; i < ypos - jumpHeight; i += 6) {
        i -= 6;
        hitObstacle = nodingHitObstacle(xpos,i);
        if(!hitObstacle) {
            var newValue;
            newValue = i;
            ypos = newValue + 6; // come back IN the ground
            i = ypos - jumpHeight; // end the loop
        }
    }
    
    hitObstacle = nodingHitObstacle(x,y);
    // if there is more ground above the position than what we can jump,
    // then it's impossible to reach that point x from the previous point x-6. The platform will end here.
    if(hitObstacle) {
        return 0;
    }
    if(not hitObstacle) {
        ypos += 6; // maybe stair?
        hitObstacle = nodingHitObstacle(x,y);
    }
    /*jumpHeight*/
    // if still nothing, you'd fall off the platform. End here
    if(not hitObstacle)
        return 0;
}
