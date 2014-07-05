team = getPlayerOppositeTeam();
class = CLASS_SNIPER;
name = "Enemy sniper";
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 8 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
pathPoint = instance_nearest(x,y,NPCSniperSpot);
task = NPC_TASK_CAMP; // default task
maxModifier = 10;
spyReactTime = 60;
seeRange = 500;
