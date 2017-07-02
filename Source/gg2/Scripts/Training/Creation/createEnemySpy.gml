team = getPlayerOppositeTeam();
class = CLASS_SPY;
name = "Enemy spy"
face = ClassSelectPortraitS;

var teamOffset;
if(team == TEAM_BLUE) teamOffset = 10
else teamOffset = 0;
subFace = 7 + teamOffset;

ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
maxModifier = 10;
