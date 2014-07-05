/*
*   argument0 - the NPC whose respawn method will be set
*   argument1 - if true, npc will respawn on a SpawnPosition object like standrad players;
*       if false, it will respawn at specified x/y pos instead
*/

var npc, yes;
npc = argument0;
npc.hasStandardRespawn = argument1;
