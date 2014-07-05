/**
*   Call this before creating any NPC and after basicRoomSetup!
*   Sets the team on which the player will be, and respawns the player - because he was already spawned.
*   argument0 - the played team
*/

var team;
team = argument0;

global.team = team;
global.myself.team = team;
if(global.myself.object != -1) {
    with(global.myself.object)
        instance_destroy();
}
global.myself.alarm[5] = 1;
