team = global.myself.team;
class = CLASS_ENGINEER;
name = "Partner"
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 6 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
pathPoint = instance_nearest(x,y,NPCSentrySpot);
task = NPC_TASK_SENTRY;
