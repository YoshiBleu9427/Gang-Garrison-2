team = getPlayerOppositeTeam();
class = CLASS_SOLDIER;
name = "Enemy rocketman";
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 2 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_CHASE; // default task
maxModifier = 5;
