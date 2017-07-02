/**
*   Call this before creating any NPC and after basicRoomSetup!
*   Sets the team on which the player will be, and respawns the player - because he was already spawned.
*   argument0 - the played team
*/

var team;
team = argument0;

global.team = team;
global.myself.team = team;
if (global.myself.object != -1) {
    var group, spawnpointID, numSpawnPoints;
    group = selectSpawnGroup(team);
    if(team == TEAM_RED) {
        numSpawnPoints = ds_list_size(global.spawnPointsRed[0,group]);
    } else {
        numSpawnPoints = ds_list_size(global.spawnPointsBlue[0,group]);
    }
    spawnpointID = floor(random(numSpawnPoints));
    sendEventSpawn(global.myself, spawnpointID, group);
    doEventSpawn(global.myself, spawnpointID, group);
    global.myself.alarm[5] = -1;
}
