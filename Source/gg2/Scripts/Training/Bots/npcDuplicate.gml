/**
 *  Duplicates an NPC.
 *  Faculative arguments: x (real), y (real)
 *  Returns a NPC instance
 *  If x and y are set, sets the copied instance to these coordinates.
 */

var xPos, yPos;
if (argument0 != noone and argument1 != noone) {
    xPos = argument0;
    yPos = argument1;
} else {
    xPos = x;
    yPos = y;
}

var copy;
copy = instance_copy(true);
with(copy) {
    x = xPos;
    y = yPos;
    object = -1;
    alarm[5] = -1;
}
return copy;
