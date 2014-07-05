/*
*   All credit goes to Orpheon's Tempest Bot
*   This was used as a template
*   Not the entire code was copied, of course.
*/

pressed = 0

target = -1

aimModifier = 0

isHealing = 0
patient = -1

if variable_local_exists("directionList")
{
    ds_list_clear(directionList)
}
else
{
    directionList = ds_list_create()
}

wasFighting = 0

dir = 1

jump = 0;
LMB = 0;
RMB = 0;

stuckTimer = 0

oldX = 0
oldY = 0

reloadCounter = 0

keybyte = 0;
aimDirection = 0;
