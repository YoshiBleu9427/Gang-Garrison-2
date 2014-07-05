team = global.myself.team;
class = CLASS_MEDIC;
name = "Dummkopf";
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 5 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_PET; // default task
maxModifier = 1;
