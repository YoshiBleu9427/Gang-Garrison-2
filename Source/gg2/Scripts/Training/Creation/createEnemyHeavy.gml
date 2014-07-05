team = getPlayerOppositeTeam();
class = CLASS_HEAVY;
name = "Enemy overweight"
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 3 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
spyReactTime = 50;
