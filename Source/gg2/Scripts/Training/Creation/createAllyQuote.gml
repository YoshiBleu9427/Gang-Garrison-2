team = global.myself.team;
class = CLASS_QUOTE;
if(team == TEAM_RED) {
    name = "Quote";
    face = QuoteRedS;
} else {
    name = "Curly";
    face = CurlyBlueS;
}
subFace = 0;
ds_list_add(global.players, id);
doEventSpawnPos(id,x,y);
task = NPC_TASK_IDLE;
