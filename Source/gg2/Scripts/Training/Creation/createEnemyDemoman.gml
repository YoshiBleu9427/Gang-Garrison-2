team = getPlayerOppositeTeam();
class = CLASS_DEMOMAN;
name = "Enemy detonator";
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 4 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_STAY; // default task
maxModifier = 1;
