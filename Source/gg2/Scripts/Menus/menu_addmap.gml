var mapName, completed, shownName;
mapName = argument0;
completed = argument1;

if (completed) {
    shownName = "[X] " + mapName
} else {
    shownName = "[ ] " + mapName
}
menu_addlink(shownName, '
    global.currentMap = "' + mapName + '";
    //Server respawn time calculator. Converts each second to a frame. (read: multiply by 30 :hehe:)
    if (global.Server_RespawntimeSec == 0)
        global.Server_Respawntime = 1;
    else
        global.Server_Respawntime = global.Server_RespawntimeSec * 30;
    global.gameServer = instance_create(0,0,GameServer);
');

