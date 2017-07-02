team = getPlayerOppositeTeam();
class = CLASS_QUOTE;
if(team == TEAM_RED) {
    name = "Quote";
    face = QuerlyRedS;
} else {
    name = "Curly";
    face = QuerlyBlueS;
}
subFace = 0;
ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_IDLE;
