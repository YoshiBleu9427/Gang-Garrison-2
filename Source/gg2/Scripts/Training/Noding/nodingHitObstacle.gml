/*
* Checks if the given point can be an obstacle for a character on any team
*/

var xpos, ypos;
xpos = argument0;
ypos = argument1;


return ((collision_point(xpos,ypos,TeamGate,true,false) <= 0)
    and (collision_point(xpos,ypos,IntelGate,true,false) <= 0)
    and (collision_point(xpos,ypos,PlayerWall,true,false) <= 0)
    and (collision_point(xpos,ypos,PlayerWallHorizontal,true,false) <= 0)
    and (collision_point(xpos,ypos,Obstacle,true,false) <= 0));
