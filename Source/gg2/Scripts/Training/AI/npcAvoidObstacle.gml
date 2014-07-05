/**
 *  All credit goes to Orpheon's Tempest Bot.
 */
 
 // THIS SCRIPT ALSO DETECTS WHEN YOU HAVE TO JUMP
 // This script tells the bot to jump when there is a crate in front, and to reverse direction when faced with an unsurmountable wall.

var jumpLength, xyshiftRatio;
jumpLength = object.hspeed * object.jumpStrength;

if(pathPoint != noone) {
    if(instance_exists(pathPoint)) {
        xyshiftRatio = abs(pathPoint.x - object.x) / max(1, (object.y - pathPoint.y));
    }
}

with object
{
    other.yOffset = sprite_height-sprite_yoffset
}

if collision_line(object.x - 6, object.y+yOffset+3, object.x + 6, object.y+yOffset+3, Obstacle, 1, 0) > 0// Only do something if you're touching the ground
{
    if collision_line(object.x+15*dir, object.y - yOffset + 6, object.x+15*dir, object.y + yOffset - 12, Obstacle, 1, 0) > 0// Is there ground in front of us at waist-height?
    {
        /*if collision_point(object.x+15*dir, object.y-yOffset-6, Obstacle, 1, 0) > 0// Is there also a wall too high to jump over for us?
        {
            dir *= -1// Change direction
        }
        else
        {*/
            jump = 1
        /*}*/
    }
    
    // avoid holes
    if collision_line(object.x+24*dir, object.y + yOffset, object.x+24*dir, object.y + yOffset + 12, Obstacle, 1, 0) <= 0// Is there ground in front of us at waist-height?
    {
        
        if(pathPoint.y < object.y) {
            jump = 1;
        } else {
            if(xyshiftRatio > 3) {
                jump = 1;
            }
        }
    }
    
    // can I jump there? (platform check first, then place free (so that I don't jump in a wall)
    if(collision_line(object.x+jumpLength, object.y + yOffset - 18, object.x+jumpLength, object.y + yOffset - 64, Obstacle, 1, 0) > 0) {
        if(collision_point(object.x+jumpLength, object.y + yOffset - 72, Obstacle, 1, 0) <= 0)
            // do I have to jump anyway
            if(pathPoint.y < object.y) {
                jump = 1;
            }
    }
}


if oldX-2 <= object.x and oldX+2 >= object.x and abs(object.x - pathPoint.x) > 32 and abs(object.y - pathPoint.y) > 32// If you're at the same place as last frame
{
    stuckTimer -= 1// Start the "stuck" alarm (see npcInitAI)
}
else
{
    stuckTimer = 0
}

if((abs(stuckTimer) mod 10 == 0) and stuckTimer < -150) {
    jump = 1;
} 
if(stuckTimer == -300) {
    dir *= -1;
}
