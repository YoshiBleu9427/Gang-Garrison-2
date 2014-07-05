team = getPlayerOppositeTeam();
class = CLASS_PYRO;
name = "Enemy firebug";
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 1 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_CHASE; // default task
maxModifier = 2;
spyReactTime = 25;
