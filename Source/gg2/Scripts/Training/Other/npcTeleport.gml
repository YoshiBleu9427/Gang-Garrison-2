var npc, tpx, tpy;
npc = argument0;
tpx = argument1;
tpy = argument2;

if(npc.object != -1) {
    npc.object.x = tpx;
    npc.object.y = tpy;
}
